{% set has_filters_available = products and has_filters_enabled and product_filters is not empty %}
{% if settings.pagination == 'infinite' %}
	{% if settings.grid_columns_desktop == '5' %}
		{% paginate by 15 %}
	{% else %}
		{% paginate by 12 %}
	{% endif %}
{% else %}
	{% if settings.grid_columns_desktop == '5' %}
		{% paginate by 50 %}
	{% else %}
		{% paginate by 48 %}
	{% endif %}
{% endif %}

{% set search_page_header_class = products ? 'd-md-none' %}

{% embed "snipplets/page-header.tpl" with { breadcrumbs: false, full_width_title: true, page_header_title_class: "h2", page_header_custom_class: search_page_header_class } %}
	{% block page_header_text %}
		{% if products %}
			{{ 'Resultados de búsqueda' | translate }}
		{% else %}
			{{ "No encontramos nada para" | translate }}<span class="ml-2">"{{ query }}"</span>
		{% endif %}
	{% endblock page_header_text %}
{% endembed %}

{% if products %}
<div class="container">
	<h4 class="d-md-none mt-2 mb-4 text-center text-md-left font-weight-normal">
		{{ "Mostrando los resultados para" | translate }}<strong class="ml-2">"{{ query }}"</strong>
	</h4>
</div>

{% include 'snipplets/grid/filters-modals.tpl' %}

<section class="category-body">
	<div class="container my-3">
		<div class="row">
			{% include 'snipplets/grid/filters-sidebar.tpl' %}
			{% include 'snipplets/grid/product-list.tpl' %}
		</div>
	</div>
</section>
{% else %}
<section class="category-body">
	<div class="container text-center text-md-left">
		<h5 class="my-4 font-weight-normal">
			{{ "Escribilo de otra forma y volvé a intentar." | translate }}
		</h5>
		<p class="h4 mb-2 font-weight-normal">{{ "Quizás te interesen los siguientes productos" | translate }}</p>
	</div>
	{% include 'snipplets/home/home-featured-products.tpl' with {'has_featured': true} %}
</section>
{% endif %}
