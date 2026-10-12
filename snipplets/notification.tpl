{# Cookie validation #}

{% if show_cookie_banner and not params.preview and not should_omit_consent_management %}
    {% set cookie_banner_position = settings.cookie_banner_position %}
    <section class="js-notification js-notification-cookie-banner cookie-terms {{ cookie_banner_position }} transition-opacity delay-200">
        <div class="form-row align-items-center">
            <div class="col col-md">
                <p class="mb-0">{{ 'Al navegar por este sitio <strong>aceptás el uso de cookies</strong> para agilizar tu experiencia de compra.' | translate }}</p>
            </div>
            <div class="col-auto col-md-auto">
                <span class="d-inline-block btn btn-default btn-close py-2 px-3 w-100 js-notification-close js-acknowledge-cookies" data-amplitude-event-name="cookie_banner_acknowledge_click">{{ "Aceptar y cerrar" | translate }}</span>
            </div>
        </div>
    </section>
{% endif %}

{% if order_notification and status_page_url %}
    <div class="js-notification js-notification-status-page notification notification-primary notification-order" style="display:none;" data-url="{{ status_page_url }}">
        <div class="container px-0">
            <div class="row align-items-center">
                <div class="col">
                    <a href="{{ status_page_url }}"><span class="btn-link font-small">{{ "Seguí acá" | translate }}</span> {{ "tu última compra" | translate }}</a>
                    <a class="js-notification-close js-notification-status-page-close ml-2" href="#">
                        <svg class="icon-inline font-body"><use xlink:href="#times"/></svg>
                    </a>
                </div>
            </div>
        </div>
    </div>
{% endif %}
{% if add_to_cart %}
    {% include "snipplets/notification-cart.tpl" %}
{% endif %}
