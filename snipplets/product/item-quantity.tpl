{# Product quantity #}

{% embed "snipplets/forms/form-input.tpl" with{type_number: true, input_value: '1', input_name: 'quantity' ~ item.id, input_custom_class: 'js-quantity-input item-quantity form-control-quantity-h text-center', input_label: false, input_append_content: true, input_group_custom_class: 'js-quantity mb-0 align-items-center', form_control_container_custom_class: '', input_min: '1', input_aria_label: 'Cambiar cantidad' | translate } %}
    {% block input_prepend_content %}
        <span class="js-quantity-down form-quantity-minus btn">
            <svg class="icon-inline"><use xlink:href="#minus"/></svg>
        </span>
    {% endblock input_prepend_content %}
    {% block input_append_content %}
        <span class="js-quantity-up form-quantity-plus btn">
            <svg class="icon-inline"><use xlink:href="#plus"/></svg>
        </span>
    {% endblock input_append_content %}
{% endembed %}
