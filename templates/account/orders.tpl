{% embed "snipplets/page-header.tpl" %}
    {% block page_header_text %}{{ "Mi cuenta" | translate }}{% endblock page_header_text %}
{% endembed %}

<section class="account-page">
    <div class="container">
        <div class="row">
            <div class="col-md-4">
                <div class="card">
                    <div class="card-header h5">{{ 'Datos Personales' | translate }}</div>
                    <div class="card-body">
                        <strong>
                            {{customer.name}}
                        </strong>
                        <span class="d-block">
                            {{customer.email}}
                        </span>
                        {% if customer.cpf_cnpj %}
                            <span class="d-block">
                                {{ 'DNI / CUIT' | translate }}: {{ customer.cpf_cnpj | format_id_number(customer.billing_country) }}
                            </span>
                        {% endif %}
                        {% if customer.business_name %}
                            <span class="d-block">
                                {{ 'Razón social' | translate }}: {{ customer.business_name }}
                            </span>
                        {% endif %}
                        {% if customer.trade_name %}
                            <span class="d-block">
                                {{ 'Nombre comercial' | translate }}: {{ customer.trade_name }}
                            </span>
                        {% endif %}
                        {% if customer.state_registration %}
                            <span class="d-block">
                                {{ 'Inscripción estatal' | translate }}: {{ customer.state_registration }}
                            </span>
                        {% endif %}
                        {% if customer.phone %}
                            <span class="d-block">
                                {{ 'Teléfono' | translate }}: {{ customer.phone }}
                            </span>
                        {% endif %}                   
                    </div>
                    <div class="card-footer">
                        {{ 'Editar mis datos' | translate | a_tag(store.customer_info_url, '', 'btn btn-line btn-small d-block') }}
                    </div>
                </div>
                {% if customer.default_address %}
                    <div class="card">
                        <div class="card-header h5">{{ 'Mis direcciones' | translate }}</div>
                        <div class="card-body">
                            <span class="d-block">
                                {{ customer.default_address | format_address_short }}
                            </span>
                        </div>
                        <div class="card-footer">
                            {{ 'Editar mis direcciones' | translate | a_tag(store.customer_addresses_url, '', 'btn btn-line btn-small d-block') }}
                        </div>
                    </div>
                {% endif %}
            </div>
            <div class="col-md-8">
                <div class="row" data-store="account-orders">
                    {% if customer.orders %}
                        {% for order in customer.orders %}
                            {% set add_checkout_link = order.pending %}
                            <div class="col-md-6 mb-3" data-store="account-order-item-{{ order.id }}">
                                {% embed "snipplets/card.tpl" with{card_footer: true, card_custom_class: 'card-collapse mb-0', card_collapse: true} %}
                                    {% block card_head %}
                                        <div class="row">
                                            <div class="col">
                                                <h4 class="m-0">
                                                     <a class="btn-link" href="{{ store.customer_order_url(order) }}"><strong>{{'Orden' | translate}} #{{order.number}}</strong></a>
                                                </h4>
                                            </div>
                                            <div class="js-card-collapse-toggle col text-right">
                                                <p class="m-0"><small>{{ order.date | i18n_date('%d/%m/%Y') }}</small></p>
                                            </div>
                                        </div>
                                    {% endblock %}
                                    {% block card_body %}
                                    <div class="row">
                                        <div class="col-7">
                                            <p class="mb-2">
                                                <svg class="icon-inline mr-1 icon-w svg-icon-text"><use xlink:href="#credit-card"/></svg> {{'Pago' | translate}}: <span class="{{ order.payment_status }}"> <strong>{{ (order.payment_status == 'pending'? 'Pendiente' : (order.payment_status == 'authorized'? 'Autorizado' : (order.payment_status == 'paid'? 'Pagado' : (order.payment_status == 'voided'? 'Cancelado' : (order.payment_status == 'refunded'? 'Reintegrado' : 'Abandonado'))))) | translate }}</strong></span>
                                            </p>
                                            <p class="mb-3">
                                                <svg class="icon-inline mr-1 icon-w svg-icon-text"><use xlink:href="#truck"/></svg> {{'Envío' | translate}}: <strong> {{ (order.shipping_status == 'fulfilled'? 'Enviado' : (order.shipping_status == 'delivered'? 'Entregado' : 'No enviado')) | translate }} </strong>
                                            </p>
                                            <div class="mb-2">
                                                <h4 class="mb-2">
                                                    <strong>{{'Total' | translate}}</strong> {{ order.total | money }}
                                                </h4>
                                                <a class="btn-link d-block" href="{{ store.customer_order_url(order) }}">{{'Ver detalle >' | translate}}</a>
                                            </div>
                                        </div>

                                        <div class="col-5">
                                            <div class="card-img-square-container">
                                                {% for item in order.items %}
                                                    {% if loop.first %} 
                                                        {% if loop.length > 1 %} 
                                                            <span class="card-img-pill">{{ loop.length }} {{'Productos' | translate }}</span>
                                                        {% endif %}
                                                        {{ item.featured_image | product_image_url("") | img_tag(item.featured_image.alt, {class: 'card-img-square'}) }}
                                                    {% endif %}
                                                {% endfor %}
                                            </div>
                                        </div>
                                    </div>
                                    {% endblock %}
                                    {% block card_foot %}
                                        {% if add_checkout_link %}
                                            <a class="btn btn-primary btn-medium d-block" href="{{ order.checkout_url | add_param('ref', 'orders_list') }}" target="_blank">{{'Realizar el pago' | translate}}</a>
                                        {% elseif order.order_status_url != null %}
                                            <a class="btn btn-primary btn-medium d-block" href="{{ order.order_status_url | add_param('ref', 'orders_list') }}" target="_blank">{% if 'Correios' in order.shipping_name %}{{'Seguí la entrega' | translate}}{% else %}{{'Seguí tu orden' | translate}}{% endif %}</a>
                                        {% endif %}
                                    {% endblock %}
                                {% endembed %}
                            </div>
                        {% endfor %}
                    {% else %}
                    <div class="col text-center">
                        <svg class="icon-inline mr-1 icon-lg svg-icon-primary"><use xlink:href="#cart"/></svg>
                        <p class="my-2">{{ '¡Hacé tu primera compra!' | translate }}</p>
                        {{ 'Ir a la tienda' | translate | a_tag(store.url, '', 'btn btn-primary btn-block mt-2') }}
                    </div>
                    {% endif %}
                </div>
            </div>
        </div>
    </div>
</section>
