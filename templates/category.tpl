{% set has_filters_available = products and has_filters_enabled and (filter_categories is not empty or product_filters is not empty) %}

{# Only remove this if you want to take away the theme onboarding advices #}
{% set show_help = not has_products %}

{% if settings.pagination == 'infinite' %}
	{% if settings.grid_columns_desktop == '5' %}
		{% paginate by 15 %}
	{% else %}
		{% paginate by 12 %}
	{% endif %}
{% else %}
	{% if settings.grid_columns_desktop == '5' %}
		{% paginate by 30 %}
	{% else %}
		{% paginate by 24 %}
	{% endif %}
{% endif %}

{% if not show_help %}

{% set category_banner = (category.images is not empty) or ("banner-products.jpg" | has_custom_image) or ("banner-products-mobile.jpg" | has_custom_image) %}
{% set category_banner_footer = ("banner-products-footer.jpg" | has_custom_image) or ("banner-products-footer-mobile.jpg" | has_custom_image) %}
{% set has_category_description_without_banner = not category_banner and category.description %}

{% if category_banner %}
    {% include 'snipplets/category-banner.tpl' %}
{% endif %}

<section class="d-md-none category-title container">
	<div class="row no-gutters">
		<div class="col-12 text-center text-md-left mb-3">
			<h1 class="text-heading my-0" data-store="page-title">{{ category.name }}</h1>
			{% include 'snipplets/breadcrumbs.tpl' %}
		</div>
		{% if category.description %}
		<div class="col-12 category-description pt-3 mb-4">
			<p class="mb-0">{{ category.description }}</p>
		</div>
		{% endif %}
	</div>
</section>

{% include 'snipplets/grid/filters-modals.tpl' %}

<section class="category-body {% if settings.filters_desktop_modal %}pt-md-2{% endif %}" data-store="category-grid-{{ category.id }}">
	<div class="container my-3">
		<div class="row">
			{% include 'snipplets/grid/filters-sidebar.tpl' %}
			{% include 'snipplets/grid/product-list.tpl' with {desktop_modal_filters: true} %}
		</div>
	</div>
</section>

{% if settings.category_content %}
	<div id="seo-content-area"></div>
{% endif %}

{% if category_banner_footer %}
    {% include 'snipplets/category-banner.tpl' with {banner_footer: true} %}
{% endif %}

{% elseif show_help %}
	{# Category Placeholder #}
	{% include 'snipplets/defaults/show_help_category.tpl' %}
{% endif %}
