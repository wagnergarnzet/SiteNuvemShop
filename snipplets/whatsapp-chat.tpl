{% if store.whatsapp %}
    <a href="{{ store.whatsapp }}{% if settings.wpp_message %}?text={{ settings.wpp_message }}{% endif %}" target="_blank" class="btn-whatsapp" aria-label="{{ 'Comunicate por WhatsApp' | translate }}">
        <svg class="icon-inline icon-2x"><use xlink:href="#whatsapp"/></svg>
    </a>
{% endif %}
