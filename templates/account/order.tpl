{% embed "snipplets/page-header.tpl" %}
    {% block page_header_text %}{{ 'Orden {1}' | translate(order.number) }}{% endblock page_header_text %}
{% endembed %}

<section class="account-page">
    <div class="container" data-store="account-order-detail-{{ order.id }}">
    	<div class="row">
            <div class="col-md-4">
                {% if log_entry %}
                    <div class="alert alert-info">
                        <strong>{{ 'Estado actual del envío' | translate }}:</strong> {{ log_entry }}
                    </div>
                {% endif %}                      
                <div class="card">
                    <div class="card-header h5">{{ 'Detalles del pedido' | translate }}</div>
                    <div class="card-body">
                        <p>
                            <svg class="icon-inline svg-icon-text"><use xlink:href="#calendar-alt"/></svg>
                            <strong>{{'Fecha' | translate}}:</strong> {{ order.date | i18n_date('%d/%m/%Y') }}
                        </p>
                        <p>
                            <svg class="icon-inline svg-icon-text"><use xlink:href="#info-circle"/></svg>
                            <strong>{{'Estado' | translate}}:</strong> {{ (order.status == 'open'? 'Abierta' : (order.status == 'closed'? 'Cerrada' : 'Cancelada')) | translate }}
                        </p>
                        <p>
                            <svg class="icon-inline svg-icon-text"><use xlink:href="#credit-card-blank"/></svg>
                            <strong>{{'Pago' | translate}}:</strong> {{ (order.payment_status == 'pending'? 'Pendiente' : (order.payment_status == 'authorized'? 'Autorizado' : (order.payment_status == 'paid'? 'Pagado' : (order.payment_status == 'voided'? 'Cancelado' : (order.payment_status == 'refunded'? 'Reintegrado' : 'Abandonado'))))) | translate }}
                        </p>
                        <p>
                            <svg class="icon-inline svg-icon-text"><use xlink:href="#usd-circle"/></svg>
                            <strong>{{'Medio de pago' | translate}}:</strong> {{ order.payment_name }}
                        </p>
                        {% if order.address %}
                            <p>
                                <svg class="icon-inline icon-w mr-1 svg-icon-text"><use xlink:href="#truck"/></svg>
                                <strong>{{'Envío' | translate}}:</strong> {{ (order.shipping_status == 'fulfilled'? 'Enviado' : (order.shipping_status == 'delivered'? 'Entregado' : 'No enviado')) | translate }}
                            </p>
                        {% endif %}
                    </div>
                </div>

                {% if order.address %}
                    <div class="card">
                        <div class="card-header h5">{{ 'Dirección de envío' | translate }}</div>
                        <div class="card-body">
                            {{ order.address | format_address }}
                        </div>
                    </div>
                {% endif %}                
            </div>
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header h5">{{ 'Productos' | translate }}</div>
                    <div class="card-body">
                        <div class="d-none d-md-block">
                            <div class="row">
                                <div class="col-6">
                                    <p><strong>{{ 'Producto' | translate }}</strong></p>
                                </div>
                                <div class="col-2">
                                    <p><strong>{{ 'Precio' | translate }}</strong></p>
                                </div>
                                <div class="col-2">
                                    <p><strong>{{ 'Cantidad' | translate }}</strong></p>
                                </div>
                                <div class="col-2">
                                    <p><strong>{{ 'Total' | translate }}</strong></p>
                                </div>
                            </div>
                        </div>
                        <div class="order-detail">
                            {% for item in order.items %}
                                <div class="order-item">
                                    <div class="row align-items-center">
                                        <div class="col-7 col-md-6">
                                            <div class="row align-items-center">
                                                <div class="col-4">
                                                    {{ item.featured_image | product_image_url("small") | img_tag(item.featured_image.alt, {class: 'd-block img-fluid'}) }} 
                                                </div>
                                                <div class="col-8">
                                                    <p>
                                                        <strong>{{ item.name }}</strong> <span class="d-inline-block d-md-none">x{{ item.quantity }}</span>
                                                    </p>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-2 d-none d-md-block">
                                            <p>
                                                {{ item.unit_price | money }}
                                            </p>
                                        </div>
                                        <div class="col-2 d-none d-md-block">
                                            <p>
                                                {{ item.quantity }}
                                            </p>
                                        </div>
                                        <div class="col-5 col-md-2">
                                            <p>
                                                {{ item.subtotal | money }}
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            {% endfor %}
                        </div>
                    </div>
                    <div class="card-footer">
                        <div class="row">
                            <div class="col-12 col-md-7 text-center text-md-left">
                                {% if order.shipping or order.discount %}
                                    <p class="mt-3">
                                        <strong>{{ 'Subtotal' | translate }}:</strong>
                                        {{ order.subtotal | money }}
                                    </p>
                                {% endif %}
                                {% if order.discount %}
                                    <p class="mt-3">
                                    <strong>{{ 'Descuento ({1})' | translate(order.coupon) }}:</strong>
                                        - {{ order.discount | money }}
                                    </p>
                                {% endif %}
                                {% if order.show_shipping_price %}
                                    <p class="mt-3">
                                        <strong>{{ 'Costo de envío ({1})' | translate(order.shipping_name) }}:</strong>
                                        {% if order.shipping == 0  %}
                                            {{ 'Gratis' | translate }}
                                        {% else %}
                                            {{ order.shipping | money_long }}
                                        {% endif %}
                                    </p>
                                {% else %}
                                    <p class="mt-3">
                                        <strong>{{ 'Costo de envío ({1})' | translate(order.shipping_name) }}:</strong>
                                        {{ 'A convenir' | translate }}
                                    </p>
                                {% endif %}
                            </div>
                            <div class="col-12 col-md-5 text-center text-md-right">
                                <div class="text-brand h4 mb-3">
                                    <strong>{{ 'Total' | translate }}:</strong>
                                    <strong>{{ order.total | money }}</strong>
                                </div>
                                {% if order.pending %}
                                    <a class="btn btn-primary d-inline-block" href="{{ order.checkout_url | add_param('ref', 'orders_details') }}" target="_blank">{{ 'Realizar el pago' | translate }}</a>
                                {% endif %}
                            </div>
                        </div>
                    </div>                                
                </div>
            </div>
    	</div>
    </div>
</section>
