{% set newsletter_contact_error = contact.type == 'newsletter' and not contact.success %}
{% set inline_form = inline_form | default(false) %}
{% set inline_block = inline_block | default(false) %}

<div class="js-newsletter newsletter{% if inline_block %} row align-items-center justify-content-between{% endif %}" data-store="newsletter-form">
    
    {% if inline_block %}
        <div class="col-md-auto pr-md-0 mb-2 mb-md-0">
            <svg class="icon-inline icon-2x icon-2"><use xlink:href="#icon-email"/></svg>
        </div>
    {% endif %}
    {% if inline_block %}
    <div class="col-12 col-md-auto text-md-left">
    {% endif %}
    {% if settings.news_title %}
        <div class="h4 text-center text-lg-left {% if inline_block %}mb-3 {% if settings.news_text %}mb-md-1{% else %}mb-md-0{% endif %}{% else %}mb-2{% endif %}">{{ settings.news_title }}</div>
    {% endif %}
    {% if settings.news_text %}
        <p {% if inline_block %}class="mb-md-0"{% endif %}>{{ settings.news_text }}</p>
    {% endif %}
    {% if inline_block %}        
        </div>
    {% endif %}

    {% if contact and contact.type == 'newsletter' %}
        {% if contact.success %}
            <div class="alert alert-success">{{ "¡Gracias por suscribirte! A partir de ahora vas a recibir nuestras novedades en tu email" | translate }}</div>
        {% else %}
            <div class="alert alert-danger">{{ "Necesitamos tu nombre y un email para enviarte nuestras novedades." | translate }}</div>
        {% endif %}
    {% endif %}

    {% if inline_form %}
    <form class="{% if inline_block %}col {% endif %}d-flex flex-column flex-md-row justify-content-between" method="post" action="/winnie-pooh" onsubmit="this.setAttribute('action', '');">

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
        <input type="submit" name="contact" class="btn btn-primary btn-submit" value='{% if settings.news_send %}{{ settings.news_send }}{% else %}{{ "OK" | translate }}{% endif %}'>    
    </form>
    {% else %}
    <form class="d-flex flex-column flex-md-row flex-wrap justify-content-between" method="post" action="/winnie-pooh" onsubmit="$(this).attr('action', '');">
        {# Name input #}

        {% embed "snipplets/forms/form-input-inline.tpl" with{input_for: 'name', type_text: true, input_name: 'name', input_id: 'name', input_custom_class: 'flex-grow-1 col-12 mr-0 mb-2', input_placeholder: 'Nombre' | translate, input_aria_label: 'Nombre' | translate } %}
        {% endembed %}

        {% if settings.news_phone %}

            {# Phone input #}

            {% embed "snipplets/forms/form-input-inline.tpl" with{input_for: 'phone', type_text: true, input_name: 'phone', input_id: 'phone', input_custom_class: 'col-12 phone flex-grow-1 mb-2', input_placeholder: 'Teléfono/WhatsApp' | translate, input_aria_label: 'Teléfono/WhatsApp' | translate } %}
            {% endembed %}

        {% endif %}

        {# Email input #}

        {% embed "snipplets/forms/form-input-inline.tpl" with{input_for: 'email', type_email: true, input_name: 'email', input_id: 'email', input_custom_class: 'col-12 col-md flex-grow-1 mb-2 mb-md-0', input_placeholder: 'Email' | translate, input_aria_label: 'Email' | translate } %}
        {% endembed %}

        <div class="winnie-pooh" style="display: none;">
            <label for="winnie-pooh-newsletter">{{ "No completar este campo" | translate }}</label>
            <input id="winnie-pooh-newsletter" type="text" name="winnie-pooh"/>
        </div>
        <input type="hidden" name="message" value="{{ "Pedido de inscripción a newsletter" | translate }}" />
        <input type="hidden" name="type" value="newsletter" />
        <input type="submit" name="contact" class="col-12 col-md-auto btn btn-primary btn-submit" value='{% if settings.news_send %}{{ settings.news_send }}{% else %}{{ "OK" | translate }}{% endif %}'>    
    </form>
    {% endif %}
</div>
