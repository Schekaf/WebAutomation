def before_feature(context, feature):
    pass


def before_scenario(context, scenario):
    pass


def before_step(context, step):
    pass


def after_step(context, step):
    pass


def after_scenario(context, scenario):
    context.driver.quit()


def after_feature(context, feature):
    pass
