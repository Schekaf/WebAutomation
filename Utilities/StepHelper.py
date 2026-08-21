import functools
import random
import tkinter as tk
from datetime import datetime
from behave import (
    step as behave_step,
    given as behave_given,
    when as behave_when,
    then as behave_then,
)

# Global storage for dynamically generated values during test execution
_VARIABLE_CACHE = {
    "last_random": ""
}


# --- 1. Helper Logic ---

def _get_clipboard_text():
    """Retrieves text from the OS clipboard using tkinter."""
    try:
        root = tk.Tk()
        root.withdraw()
        content = root.clipboard_get()
        root.destroy()
        return str(content)
    except Exception:
        return ""


def _process_single_val(val):
    """Processes dynamic keyword placeholders and manages state caching."""
    # 1. Standard Date & Clipboard
    if "<TODAY>" in val:
        val = val.replace("<TODAY>", datetime.today().strftime("%d/%m/%Y"))

    if "<PASTE>" in val:
        val = val.replace("<PASTE>", _get_clipboard_text())

    # 2. Variable Length Random String / Plain Random String (<RANDOM> or <RANDOM:8>)
    # Checks for digits after the colon (e.g., <RANDOM:8>) vs plain <RANDOM>
    random_len_match = re.search(r"<RANDOM(?::(\d+))?>", val)
    if random_len_match:
        length = (
            int(random_len_match.group(1))
            if random_len_match.group(1)
            else 6
        )
        rand_str = "".join(random.choices(string.ascii_letters, k=length))
        _VARIABLE_CACHE["last_random"] = rand_str  # Cache for <GETRANDOM>

        # Replace only the specific matched tag (<RANDOM> or <RANDOM:8>)
        tag_to_replace = random_len_match.group(0)
        val = val.replace(tag_to_replace, rand_str, 1)

    # 3. Retrieve Last Random String (<GETRANDOM>)
    if "<GETRANDOM>" in val:
        last_rand = _VARIABLE_CACHE.get("last_random", "")
        val = val.replace("<GETRANDOM>", last_rand)

    # 4. Named Caching: <RANDOM:key_name> (where key_name is non-numeric, e.g., <RANDOM:user_id>)
    if "<RANDOM:" in val and ">" in val:
        start = val.find("<RANDOM:") + len("<RANDOM:")
        end = val.find(">", start)
        key_name = val[start:end]

        # Only process if key_name is NOT a pure digit (to avoid clashing with <RANDOM:8>)
        if not key_name.isdigit():
            rand_num = str(random.randint(1000, 9999))
            _VARIABLE_CACHE[key_name] = rand_num
            val = val.replace(f"<RANDOM:{key_name}>", rand_num)

    if "<GET:" in val and ">" in val:
        start = val.find("<GET:") + len("<GET:")
        end = val.find(">", start)
        key_name = val[start:end]
        cached_val = _VARIABLE_CACHE.get(key_name, "")
        val = val.replace(f"<GET:{key_name}>", cached_val)

    return val

# --- 2. Decorator Functionalities ---

def transform_param():
    """Decorator factory that intercepts all positional (*args) and keyword (**kwargs) step arguments."""

    def decorator(func):
        @functools.wraps(func)
        def wrapper(*args, **kwargs):
            transformed_args = [_process_single_val(arg) for arg in args]
            transformed_kwargs = {k: _process_single_val(v) for k, v in kwargs.items()}
            return func(*transformed_args, **transformed_kwargs)

        return wrapper

    return decorator


# --- 3. Core Step Wrapper ---

def _create_step_wrapper(behave_decorator, step_text):
    """Wraps step implementations with stacked decorator functionality."""

    def decorator(func):
        @transform_param()
        @functools.wraps(func)
        def wrapper(*args, **kwargs):
            # Pure passthrough: Zero helper logic calls inside this wrapper
            return func(*args, **kwargs)

        return behave_decorator(step_text)(wrapper)

    return decorator


# --- 4. Overridden Step Decorators ---

def step(step_text):
    return _create_step_wrapper(behave_step, step_text)


def given(step_text):
    return _create_step_wrapper(behave_given, step_text)


def when(step_text):
    return _create_step_wrapper(behave_when, step_text)


def then(step_text):
    return _create_step_wrapper(behave_then, step_text)
