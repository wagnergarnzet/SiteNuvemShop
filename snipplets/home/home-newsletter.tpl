<section class="section-home section-newsletter" data-store="home-newsletter">

    {{ component('nubesdk-slot', { type: 'before_section_newsletter' }) }}

    <div class="container">
        <div class="row">
            <div class="col-10 col-md-12 offset-1 offset-md-0">

                {% set newsletter_contact_error = contact.type == 'newsletter' and not contact.success %}

                {% if contact and contact.type == 'newsletter' %}
                    <div class="row">
                        <div class="col-12">
                            {% if contact.success %}
                                <div class="alert alert-success">{{ "¡Gracias por suscribirte! A partir de ahora vas a recibir nuestras novedades en tu email" | translate }}</div>
                            {% else %}
                                <div class="alert alert-danger">{{ "Necesitamos tu nombre y un email para enviarte nuestras novedades." | translate }}</div>
                            {% endif %}
                        </div>
                    </div>
                {% endif %}

                <div class="js-newsletter newsletter row align-items-center">
                    {% if settings.news_title or settings.news_text %}
                        <div class="col-12 col-lg-auto d-flex align-items-center justify-content-center justify-content-md-start mb-3 mb-lg-0">
                            <div class="d-none d-md-inline-flex">
                                <svg class="icon-inline icon-2x mr-2"><use xlink:href="#icon-email"/></svg>
                            </div>
                            <div class="text-center text-lg-left">
                                {% if settings.news_title %}
                                    <div class="h3 mb-0">{{ settings.news_title }}</div>
                                {% endif %}
                                {% if settings.news_text %}
                                    <p class="mt-1 mb-0">{{ settings.news_text }}</p>
                                {% endif %}
                            </div>
                        </div>
                    {% endif %}

                    <form class="col-lg form-inline d-flex flex-column flex-md-row justify-content-between" method="post" action="/winnie-pooh" onsubmit="this.setAttribute('action', '');">
                        {# Name input #}

                        {% embed "snipplets/forms/form-input-inline.tpl" with{input_for: 'name', type_text: true, input_name: 'name', input_id: 'name', input_custom_class: 'flex-grow-1 mb-2 mb-md-0', input_placeholder: 'Nombre' | translate, input_aria_label: 'Nombre' | translate } %}
                        {% endembed %}

                        {% if settings.news_phone %}

                            {# Phone input #}

                            {% embed "snipplets/forms/form-input-inline.tpl" with{input_for: 'phone', type_text: true, input_name: 'phone', input_id: 'phone', input_custom_class: 'phone flex-grow-1 mb-2 mb-md-0', input_placeholder: 'Teléfono/WhatsApp' | translate, input_aria_label: 'Teléfono/WhatsApp' | translate } %}
                            {% endembed %}

                        {% endif %}

                        {# Email input #}

                        {% embed "snipplets/forms/form-input-inline.tpl" with{input_for: 'email', type_email: true, input_name: 'email', input_id: 'email', input_custom_class: 'flex-grow-1 mb-2 mb-md-0', input_placeholder: 'Email' | translate, input_aria_label: 'Email' | translate } %}
                        {% endembed %}

                        <div class="winnie-pooh" style="display: none;">
                            <label for="winnie-pooh-newsletter">{{ "No completar este campo" | translate }}</label>
                            <input id="winnie-pooh-newsletter" type="text" name="winnie-pooh"/>
                        </div>
                        <input type="hidden" name="message" value="{{ "Pedido de inscripción a newsletter" | translate }}" />
                        <input type="hidden" name="type" value="newsletter" />
                        <input type="submit" name="contact" class="btn btn-primary btn-submit" value='{{ "OK" | translate }}'>    
                    </form>
                </div>
            </div>
        </div>
    </div>

    {{ component('nubesdk-slot', { type: 'after_section_newsletter' }) }}

</section>
