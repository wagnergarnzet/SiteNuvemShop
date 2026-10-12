<ul class="search-suggestions-list">
    {% set search_suggestions = products | take(6) %}
    {% for product in search_suggestions %}
        <li class="search-suggestions-item container-fluid">
            <a href="{{ product.url }}" class="search-suggestions-link row justify-content-md-center">
                <div class="search-suggestions-image-container col-auto">
                    <img src="{{ 'images/empty-placeholder.png' | static_url }}" data-srcset="{{ product.featured_image | product_image_url('thumb') }} 100w" data-sizes="auto" class="search-suggestions-image lazyautosizes lazyload" alt="{{ "Foto de" | translate }} {{ product.name }}"/>
                </div>
                <div class="search-suggestions-text col">
                	<p class="search-suggestions-name">
                		{{ product.name | highlight(query) }}
                	</p>
                    {% if product.display_price %}
                    	<p>
                    		{{ product.price | money }}

                            {% set product_can_show_installments = product.show_installments and product.display_price and product.get_max_installments.installment > 1 %}
                            {% if product_can_show_installments %}
                                {% set max_installments_without_interests = product.get_max_installments(false) %}
                                {% if store.country == 'AR' %}
                                    {% set max_installments_with_interests = product.get_max_installments %}
                                    {% if max_installments_with_interests %}
                                        <span>| {{ "Hasta <strong class='installment-amount'>{1}</strong> cuotas" | t(max_installments_with_interests.installment, max_installments_with_interests.installment_data.installment_value_cents | money) }}</span>
                                    {% endif %}
                                {% else %}
                                    {% if max_installments_without_interests and max_installments_without_interests.installment > 1 %}
                                        <span>| {{ "<strong class='installment-amount'>{1}</strong> cuotas sin interés de <strong class='installment-price'>{2}</strong>" | t(max_installments_without_interests.installment, max_installments_without_interests.installment_data.installment_value_cents | money) }}</span>
                                    {% else %}
                                        {% set max_installments_with_interests = product.get_max_installments %}
                                        {% if max_installments_with_interests %}
                                            <span>| {{ "<strong class='installment-amount'>{1}</strong> cuotas de <strong class='installment-price'>{2}</strong>" | t(max_installments_with_interests.installment, max_installments_with_interests.installment_data.installment_value_cents | money) }}</span>
                                        {% endif %}
                                    {% endif %}
                                {% endif %}
                            {% endif %}
                    	</p>
                    {% endif %}
                </div>
                <div class="col-auto pt-3">
                    <svg class="icon-inline icon-lg icon-flip-horizontal"><use xlink:href="#chevron"/></svg>
                </div>
            </a>
        </li>
    {% endfor %}
    <a href="#" class="js-search-suggestions-all-link btn btn-primary btn-medium d-block">{{ 'Ver todos los resultados' | translate }}</a>
</ul>
