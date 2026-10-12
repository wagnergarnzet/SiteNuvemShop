{% set list_data_store = template == 'category' ? 'category-grid-' ~ category.id : 'search-grid' %}

<div class="col" data-store="{{ list_data_store }}">
	{% if desktop_modal_filters %}
		<div class="d-none d-md-flex align-items-center row no-gutters mb-4">
			<div class="col-12 col-md {% if not products %}text-center{% endif %}">
				<h1 class="text-heading my-0" data-store="page-title">{{ category.name }}</h1>
				{% include 'snipplets/breadcrumbs.tpl' %}
			</div>
			{% if products %}
				<div class="col-md text-center">
					{% include 'snipplets/grid/product-counter.tpl' %}
				</div>
				<div class="col-12 col-md text-right">
					{% include 'snipplets/grid/sort-by.tpl' %}
				</div>
				{% if settings.filters_desktop_modal %}
					<a href="#" class="js-modal-open d-none d-md-block btn btn-line btn-small btn-filters ml-2" data-toggle="#nav-filters" data-component="filter-button">
						<div class="d-flex justify-content-center align-items-center">
							<svg class="icon-inline icon-lg mr-2"><use xlink:href="#filter"/></svg>
							{{ 'Filtrar' | t }}
							{% if has_applied_filters %}
								(<span class="js-filters-total-badge"></span>)
							{% endif %}
						</div>
					</a>
				{% endif %}
			{% endif %}
			{% if category.description %}
				<div class="col-12">
					<p class="mt-3 mb-4 pb-1">{{ category.description }}</p>
				</div>
			{% endif %}
		</div>
	{% endif %}
	{% if template == 'search' %}
		<div class="d-none d-md-flex align-items-center row no-gutters mb-4">
			<div class="col-md">
				<h1 class="text-heading my-0" data-store="page-title">{{ 'Resultados de búsqueda' | translate }}</h1>
				<h4 class="mt-2 mb-0 text-left font-weight-normal">
					{{ "Mostrando los resultados para" | translate }}<strong class="ml-2">"{{ query }}"</strong>
				</h4>
			</div>
			{% if products %}
				<div class="col-12 col-md-auto text-right">
					{% include 'snipplets/grid/sort-by.tpl' %}
				</div>
				{% if settings.filters_desktop_modal and search_filter and has_filters_available %}
					<div class="col-auto pl-2">
						<a href="#" class="js-modal-open d-none d-md-block btn btn-line btn-small btn-filters" data-toggle="#nav-filters" data-component="filter-button">
							<div class="d-flex justify-content-center align-items-center">
								<svg class="icon-inline icon-lg mr-2"><use xlink:href="#filter"/></svg>
								{{ 'Filtrar' | t }}
								{% if has_applied_filters %}
									(<span class="js-filters-total-badge"></span>)
								{% endif %}
							</div>
						</a>
					</div>
				{% endif %}
			{% endif %}
		</div>
	{% endif %}
	{% if products %}
		<div class="js-product-table row row-grid">
			{% include 'snipplets/product_grid.tpl' %}
		</div>
		{% if settings.pagination == 'infinite' %}
			{% set pagination_type_val = true %}
		{% else %}
			{% set pagination_type_val = false %}
		{% endif %}

		{% include "snipplets/grid/pagination.tpl" with {infinite_scroll: pagination_type_val} %}
	{% else %}
		{% if template == 'category' %}
			<div class="h6 py-5 text-center" data-component="filter.message">
				{{(has_filters_enabled ? "No tenemos resultados para tu búsqueda. Por favor, intentá con otros filtros." : "Próximamente") | translate}}
			</div>
		{% elseif template == 'search' %}
			<h5 class="my-4 font-weight-normal">
				{{ "Escribilo de otra forma y volvé a intentar." | translate }}
			</h5>
		{% endif %}
	{% endif %}
</div>
