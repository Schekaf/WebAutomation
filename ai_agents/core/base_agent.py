from typing import Optional, Any, Dict
from langchain_core.prompts import PromptTemplate
from langchain_core.output_parsers import StrOutputParser, BaseOutputParser
from langchain_ollama import ChatOllama
from ai_agents.core.config import get_agent_model
from ai_agents.core.lessons_learned_manager import LessonsLearnedManager


class BaseAgent:
    """
    Base class for all pipeline agents. Standardizes LLM instantiation,
    Lessons Learned injection, and LangChain chain construction across the pipeline.
    """

    def __init__(
        self,
        model_name: Optional[str] = None,
        lessons_manager: Optional[LessonsLearnedManager] = None,
        temperature: float = 0.0,
        num_ctx: int = 8192,
        num_predict: int = 4096,
        format_json: bool = False,
        timeout: float = 60.0,
        keep_alive: Optional[str] = None
    ):
        self.agent_name = self.__class__.__name__
        self.model_name = model_name or get_agent_model(self.agent_name)
        self.lessons_manager = lessons_manager or LessonsLearnedManager()

        # Standardized ChatOllama setup
        format_setting = "json" if format_json else None
        self.llm = ChatOllama(
            model=self.model_name,
            temperature=temperature,
            num_ctx=num_ctx,
            num_predict=num_predict,
            timeout=timeout,
            format=format_setting,
            keep_alive=keep_alive
        )

    def create_chain(self, prompt_template_str: str, output_parser: BaseOutputParser = StrOutputParser()) -> Any:
        """
        Helper method to compile a standard LangChain pipeline:
        PromptTemplate -> LLM -> StrOutputParser.
        """
        prompt = PromptTemplate.from_template(prompt_template_str)
        return prompt | self.llm | output_parser

    def invoke(self, chain: Any, input_data: Dict[str, Any]) -> Any:
        """
        Standard invocation method that automatically injects lessons learned
        context if not explicitly provided in input_data.
        """
        if "lessons_learned" not in input_data:
            input_data["lessons_learned"] = self.lessons_manager.load_lessons(self.agent_name)

        return chain.invoke(input_data)
