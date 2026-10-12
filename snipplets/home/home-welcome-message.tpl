{% set welcome_image = "welcome-image.jpg" | has_custom_image %}
{% set image_position = settings.welcome_image_side %}

{% if settings.welcome_title or settings.welcome_message %}
    <section class="section-home section-welcome-home {% if template == 'page' %}section-welcome-page page-{{ page.handle }}{% endif %}" data-store="home-welcome-message">
        <div class="container">
            <div class="row {% if welcome_image and image_position != "center" %}align-items-center justify-content-center{% endif %}">
                {% if welcome_image and image_position != "right" %}
                    <div class="{% if image_position == 'left'%}col-md-6 mb-3 mb-md-0{% else %}col-md-6 offset-md-3 mb-3{% endif %}">
                        {% if settings.welcome_link %}
                            <a href="{{ settings.welcome_link }}">
                        {% endif %}
                            <img class="img-fluid lazyload" src='{{ 'images/empty-placeholder.png' | static_url }}' data-srcset='{{ "welcome-image.jpg" | static_url | settings_image_url('large') }} 480w, {{ "welcome-image.jpg" | static_url | settings_image_url('huge') }} 640w, {{ "welcome-image.jpg" | static_url | settings_image_url('original') }} 1024w' alt="{{ 'Banner de' | translate }} {{ store.name }}"/>
                        {% if settings.welcome_link %}
                            </a>
                        {% endif %}
                    </div>
                {% endif %}
                <div class="{% if welcome_image and image_position != 'center'%}col-md-6{% else %}col-md-8 offset-md-2{% endif %}{{ image_position == 'right' ? ' order-1 order-md-0' }}">
                    {% if settings.welcome_title %}
                        <h2 class="text-heading {% if not settings.welcome_message %}mb-0{% endif %}">{{ settings.welcome_title }}</h2>
                    {% endif %}
                    {% if settings.welcome_message %}
                        <p class="my-4 h4">{{ settings.welcome_message }}</p>
                    {% endif %}
                </div>
                {% if welcome_image and image_position == "right" %}
                    <div class="col-md-6 order-0 mb-3 mb-md-0 order-md-1">
                        {% if settings.welcome_link %}
                            <a href="{{ settings.welcome_link }}">
                        {% endif %}
                            <img class="img-fluid lazyload" src='{{ 'images/empty-placeholder.png' | static_url }}' data-srcset='{{ "welcome-image.jpg" | static_url | settings_image_url('large') }} 480w, {{ "welcome-image.jpg" | static_url | settings_image_url('huge') }} 640w, {{ "welcome-image.jpg" | static_url | settings_image_url('original') }} 1024w' alt="{{ 'Banner de' | translate }} {{ store.name }}"/>
                        {% if settings.welcome_link %}
                            </a>
                        {% endif %}
                    </div>
                {% endif %}
            </div>
        </div>
    </section>
{% endif %}