{% if settings.extra_menu_show %}
    <section class="section-home section-home-extra-menu" data-store="home-extra-menu">
        {% if settings.extra_menu_title %}
        <div class="container">
            <div class="section-title {% if settings.section_title_uppercase %}section-title-uppercase{% endif %} mx-auto row">
                <div class="col-12 text-center">
                    <h2 class="text-heading mb-0">{{ settings.extra_menu_title }}</h2>
                </div>
            </div>
        </div>
        {% endif %}
        <div class="container {% if not settings.extra_menu_title %}py-4{% endif %}">
            <div class="row">
                <div class="extra-menu col-12 d-flex align-items-center justify-content-center text-center">
                    {% for item in menus[settings.extra_menu] %}
                        <a href="{{ item.url }}" {% if item.url | is_external %}target="_blank"{% endif %} title="{{ item.name }}"><span>{{ item.name }}</span></a>
                    {% endfor %}
                </div>
            </div>
        </div>
    </section>
{% endif %}