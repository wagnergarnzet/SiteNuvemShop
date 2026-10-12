{% if sections.featured.products %}
	{% if settings.main_product_type == 'random' %}
		{% set product_type = sections.featured.products | shuffle | take(1) %}
	{% else %}
		{% set product_type = sections.featured.products | take(1) %}
	{% endif %}

	{% for product in product_type %}
		<section id="single-product" class="js-product-container section-home home-main-product" data-variants="{{product.variants_object | json_encode }}" data-store="home-product-main">
			{% if settings.main_product_title or settings.main_product_subtitle %}
				<div class="container">
					<div class="section-title {% if settings.section_title_uppercase %}section-title-uppercase{% endif %} mx-auto row">
						{% if settings.main_product_title %}
						<div class="col-12 text-center">
							<h2 class="text-heading mb-0">{{ settings.main_product_title }}</h2>
						</div>
						{% endif %}
						{% if settings.main_product_subtitle %}
						<div class="col-12 text-center mt-2">
							<p class="home-subtitle text-subtitle">{{ settings.main_product_subtitle }}</p>
						</div>
						{% endif %}
					</div>
				</div>
			{% endif %}
			<div class="container">
				<div class="row justify-content-md-center">
					<div class="col-11 mx-auto col-md-10">
							<div class="row">
								<div class="col-md-7">
									{% include 'snipplets/product/product-image.tpl' with { home_main_product: true } %}
								</div>
								<div class="col d-md-flex flex-md-column justify-content-md-center" data-store="product-info-{{ product.id }}">
									{% include 'snipplets/product/product-form.tpl' with { home_main_product: true } %}
									{% if (settings.main_product_description and product.description is not empty) %}
										<div class="{% if settings.product_stock %}mt-1{% else %}mt-2{% endif %}">
											{# Product description #}
											<div class="js-product-description product-description user-content font-small">
												{{ product.description }}
											</div>
											<div class="js-view-description" style="display: none;">
												<div class="btn-link font-small mt-3">
													{% if settings.positive_color_background %}
														{% set view_description_icon_class = 'icon-inline icon-lg svg-icon-invert ml-1' %}
													 {% else %}
														{% set view_description_icon_class = 'icon-inline icon-lg svg-icon-text ml-1' %}
													{% endif %}
													<span class="js-view-more">
														{{ "Ver más" | translate }}
													</span>
													<span class="js-view-less" style="display: none;">
														{{ "Ver menos" | translate }}
													</span>
												</div>
											</div>
										</div>
									{% endif %}
								</div>
							</div>
					</div>
				</div>
			</div>
		</section>
	{% endfor %}
{% endif %}
