<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:fb="http://www.facebook.com/2008/fbml" xmlns:og="http://opengraphprotocol.org/schema/" lang="{% for language in languages %}{% if language.active %}{{ language.lang }}{% endif %}{% endfor %}">
    <head>
        <link rel="preconnect" href="{{ store_resource_hints }}" />
        <link rel="dns-prefetch" href="{{ store_resource_hints }}" />
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>{{ page_title }}</title>
        <meta name="description" content="{{ page_description }}" />
        {% include "static/css/style-fonts.tpl" %}
        <link rel="preload" href="{{ 'js/external-no-dependencies.js.tpl' | static_url }}" as="script" />

        {% if settings.theme_color and settings.primary_color %}
            <meta name="theme-color" content="{{ settings.primary_color|raw }}" />
        {% endif %}

        {{ component('social-meta') }}

        {#/*============================================================================
            #CSS and fonts
        ==============================================================================*/#}

        <style>
            {# Font families #}

            {% include "static/css/style-fonts.tpl" with {import_style: true} %}
            
            {# General CSS Tokens #}

            {% include "static/css/style-tokens.tpl" %}
        </style>

        {{ 'css/style-critical.scss' | static_url | static_inline }}

        {# Colors and fonts used from settings.txt and defined on theme customization #}

        {{ 'css/style-colors.scss.tpl' | static_url | static_inline }}

        {# Load async styling not mandatory for first meaningfull paint #}

        <link rel="stylesheet" href="{{ 'css/style-async.scss.tpl' | static_url }}" media="print" onload="this.media='all'">

        {# Loads custom CSS added from Advanced Settings on the admin´s theme customization screen #}

        <style>
            {{ settings.css_code | raw }}
        </style>

        {#/*============================================================================
            #Javascript: Needed before HTML loads
        ==============================================================================*/#}

        {# Defines if async JS will be used by using script_tag(true) #}

        {% set async_js = true %}

        {# Defines the usage of jquery loaded below, if nojquery = true is deleted it will fallback to jquery 1.5 #}

        {% set nojquery = true %}

        {# Jquery async by adding script_tag(true) #}

        {{ '//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js' | script_tag(true) }}

        {# Loads private Tienda Nube JS #}

        {% head_content %}

        {# Structured data to provide information for Google about the page content #}

        {{ component('structured-data') }}

    </head>
    <body class="{% if customer %}customer-logged-in{% endif %} template-{{ template | replace('.', '-') }} {% if settings.head_fix_desktop %}js-head-offset head-offset{% endif %} page--password">

        {# Theme icons #}

        {% include "snipplets/svg/icons.tpl" %}

        {# Back to admin bar #}

        {{back_to_admin}}

        {# Page content #}

        <header class="head-main head-{{ settings.head_background }}">
            <div class="container">
                <div class="row justify-content-md-center">
                    <div class="col-md-8 text-center">
                        <div class="my-2">
                            {% snipplet "header/header-logo.tpl" %}
                        </div>
                    </div>
                </div>
            </div>
        </header>

        <section class="section-password">
            <div class="container">
                <div class="row justify-content-md-center">
                    <div class="col-md-8 pt-5 pb-4 text-center">

                        {% if settings.password_banner_position == "top" %}
                            {% include 'snipplets/password-banner.tpl' %}
                        {% endif %}

                        <h2 class="mb-5">{{ message }}</h2>

                        {% if settings.password_banner_position == "bottom" %}
                            {% include 'snipplets/password-banner.tpl' %}
                        {% endif %}

                        {% embed "snipplets/forms/form.tpl" with{form_id: 'password-form', submit_text: 'Desbloquear' | translate } %}
                            {% block form_body %}

                                {% embed "snipplets/forms/form-input.tpl" with{input_for: 'password', type_password: true, input_name: 'password', input_help: true, input_help_link: store.customer_reset_password_url, input_label_text: 'Contraseña de acceso' | translate } %}
                                    {% block input_form_alert %}
                                        {% if invalid_password == true %}
                                            <div class="alert alert-danger">{{ 'La contraseña es incorrecta.' | translate }}</div>
                                        {% endif %}
                                    {% endblock input_form_alert %}
                                {% endembed %}

                            {% endblock %}
                        {% endembed %}

                        {% if settings.password_banner_position == "form" %}
                            {% include 'snipplets/password-banner.tpl' with { position: 'form' } %}
                        {% endif %}

                    </div>
                </div>
            </div>
        </section>
        

        {# Footer #}

        {% snipplet "footer/footer.tpl" %}
        
        {# Javascript needed to footer logos lazyload #}

        <script type="text/javascript">

            {# Libraries that do NOT depend on other libraries, e.g: Jquery #}

            {% include "static/js/external-no-dependencies.js.tpl" %}

        </script>

        {{ component('google-survey') }}

    </body>
</html>
