{% set has_image = "newsletter_image.jpg" | has_custom_image %}

{% embed "snipplets/modal.tpl" with{modal_id: 'home-modal', modal_class: 'bottom modal-overflow-none home-popup' ~ (has_image ? ' has-image' : ''), modal_position: 'bottom', modal_position_desktop: 'centered', modal_transition: 'slide', modal_footer: false, modal_width: ' modal-centered-medium h-auto', modal_header_class: 'modal-header-reverse d-none', modal_body_class: 'modal-scrollable p-0'} %}
    {% block modal_body %}
        <a class="js-modal-close modal-close {% if modal_close_floating %}modal-close-floating{% endif %}">
            <svg class="icon-inline"><use xlink:href="#times"/></svg>
        </a>
        <div class="row no-gutters {% if not settings.home_popup_form %}align-items-center justify-content-center{% endif %}">
            {% if settings.home_popup_form and "newsletter_image.jpg" | has_custom_image %}
                {% if "newsletter_image.jpg" | has_custom_image %}
                    <div class="col-12 col-md-6 home-popup-image">
                        {% if settings.home_popup_url %}
                        <a href="{{ settings.home_popup_url }}"{% if settings.home_popup_external %} target="_blank"{% endif %}>
                        {% endif %}
                        <img src="{{ 'images/empty-placeholder.png' | static_url }}" data-srcset='{{ "newsletter_image.jpg" | static_url | settings_image_url('large') }} 480w, {{ "newsletter_image.jpg" | static_url | settings_image_url('huge') }} 640w' class="lazyload fade-in img-fluid"/>
                        {% if settings.home_popup_url %}
                        </a>
                        {% endif %}
                    </div>
                {% endif %}
            {% else %}
                {% if "newsletter_image.jpg" | has_custom_image %}
                    {% if settings.home_popup_url %}
                        <a href="{{ settings.home_popup_url }}" style="line-height:0;"{% if settings.home_popup_external %} target="_blank"{% endif %}>
                    {% endif %}
                        <img src="{{ 'newsletter_image.jpg' | static_url }}" class="img-fluid">
                    {% if settings.home_popup_url %}
                        </a>
                    {% endif %}
                {% endif %}
            {% endif %}
            {% if settings.home_popup_form %}
            <div class="col-12 {% if 'newsletter_image.jpg' | has_custom_image %}col-md-6{% endif %} newsletter p-3 text-center d-flex flex-column align-items-center justify-content-center">
                <div id="logo" class="logo-newsletter-container {% if not has_logo %}hidden{% else %} d-none d-md-block{% endif %} mx-auto">
                    {% if settings.home_popup_logo %}
                        <div id="logo" class="logo-newsletter-container {% if not has_logo %}hidden{% else %} d-none d-md-block{% endif %} mx-auto">
                            {% if 'newsletter_logo.jpg'| has_custom_image %}
                                {{ 'newsletter_logo.jpg' | static_url | img_tag(store.name, {class: 'logo-img transition-soft-slow'}) | a_tag(store.url) }}
                            {% else %}
                                {{ store.logo('medium') | img_tag(store.name, {class: 'logo-img transition-soft-slow'}) | a_tag(store.url) }}
                            {% endif %}
                        </div>
                    {% endif %}
                </div>
                <div id="no-logo" class="logo-text-container {% if has_logo %} hidden{% endif %} m-auto">
                    <a class="logo-text h2" href="{{ store.url }}">{{ store.name }}</a>
                </div>
                {% if settings.news_popup_txt %}
                    <p class="{% if not has_logo or not settings.home_popup_logo %}pr-4{% endif %}">{{ settings.news_popup_txt }}</p>
                {% endif %}
                {% if settings.home_popup_form %}
                <div id="news-popup-form-container">
                    <form id="news-popup-form" method="post" action="/winnie-pooh" class="js-news-form">
                        <div class="input-append">                         
                            {# Name input #}

                            {% embed "snipplets/forms/form-input.tpl" with{input_for: 'name', type_text: true, input_name: 'name', input_id: 'name', input_placeholder: 'Nombre' | translate, input_aria_label: 'Nombre' | translate } %}
                            {% endembed %}

                            {% if settings.news_phone %}

                                {# Phone input #}

                                {% embed "snipplets/forms/form-input.tpl" with{input_for: 'phone', type_text: true, input_name: 'phone', input_id: 'phone', input_custom_class: 'phone', input_placeholder: 'Teléfono/WhatsApp' | translate, input_aria_label: 'Teléfono/WhatsApp' | translate } %}
                                {% endembed %}

                            {% endif %}
                            
                            {# Email input #}

                            {% embed "snipplets/forms/form-input.tpl" with{input_for: 'email', type_email: true, input_name: 'email', input_id: 'email', input_placeholder: 'Email' | translate, input_aria_label: 'Email' | translate } %}
                            {% endembed %}

                            <div class="winnie-pooh" style="display: none;">
                                <label for="winnie-pooh-newsletter">{{ "No completar este campo" | translate }}</label>
                                <input id="winnie-pooh-newsletter" type="text" name="winnie-pooh"/>
                            </div>
                            <input type="hidden" name="message" value="{{ "Pedido de inscripción a newsletter" | translate }}" />
                            <input type="hidden" name="type" value="newsletter" />
                            <div class="js-news-spinner text-center" style="display: none;">
                                <svg class="icon-inline"><use xlink:href="#sync-alt"/></svg>
                            </div>
                            <div style='display: none;' class="js-news-popup-success alert alert-success">{{ settings.news_popup_success_txt ? settings.news_popup_success_txt : "¡Gracias por suscribirte! A partir de ahora vas a recibir nuestras novedades en tu email" | translate }}</div>
                            <div style='display: none;'class="js-news-popup-failed alert alert-danger">{{ "Necesitamos tu nombre y un email para enviarte nuestras novedades." | translate }}</div>
                            <input type="submit" name="contact" class="js-news-send w-100 btn btn-default" value='{{ "Quiero suscribirme" | translate }}'>    
                        </div>
                    </form>
                    <span class="text-muted font-smallest d-inline-block mt-1">{{ 'Respetamos tus datos. No enviamos spam' | translate }}.</span>
                </div>
                {% endif %}
            </div>
            {% endif %}
        </div>
    {% endblock %}
{% endembed %}