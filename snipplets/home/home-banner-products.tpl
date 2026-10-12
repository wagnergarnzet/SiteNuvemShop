{% set inner_content = settings.banner_products_show == "text" and (settings.banner_products_box_title or settings.banner_products_description or settings.banner_products_button_text) %}
{% set sections_products = sections.selection.products %}

{% if settings.banner_products_show == "banner" %}
	{% set show_banner = true %}
{% endif %}

{% if show_banner and ("banner_products.jpg" | has_custom_image or "banner_products_mobile.jpg" | has_custom_image) %}{% set has_banner = true %}{% endif %}

{% set columns_desktop = settings.banner_products_columns %}
{% set section_columns_mobile = settings.banner_products_mobile %}
{% set columns_desktop_class = columns_desktop == 2 ? 'col-md-4' : columns_desktop == 3 ? 'col-md-3' : columns_desktop == 4 ? 'col-md-2-4' %}

{% if sections_products %}
<section class="home-promos section-home {% if settings.banner_product_colors %}section-home-color section-banner-products-home-colors{% endif %}" data-store="home-banner-products">
	{% if settings.banner_products_title %}
		<div class="container mb-3">
			{% if settings.banner_products_show == "products" %}
				<div class="section-title {% if settings.section_title_uppercase %}section-title-uppercase{% endif %} mx-auto row">
					<div class="col-12 text-center">
						<h2 class="text-heading mb-0">{{ settings.banner_products_title }}</h2>
					</div>
				</div>
			{% else %}
				<div class="row">
					<div class="col-12 col-lg-11 p-0 text-center text-lg-left">
						<h2 class="title text-heading mb-0">{{ settings.banner_products_title }}</h2>
					</div>
					<div class="promos-navigation-outside d-none d-lg-block col-lg-1 text-md-right p-0">
						<div class="js-swiper-promos-prev swiper-button-prev swiper-button-prev-inside d-none d-md-block">
							<svg class="icon-inline icon-lg icon-flip-horizontal"><use xlink:href="#chevron"/></svg>
						</div>
						<div class="js-swiper-promos-next swiper-button-next swiper-button-next-inside d-none d-md-block">
							<svg class="icon-inline icon-lg"><use xlink:href="#chevron"/></svg>
						</div>
					</div>
				</div>
			{% endif %}
		</div>
	{% endif %}
	<div class="container pb-3 {% if show_banner or inner_content %}rounded-theme{% endif %} position-relative content">
		{% if show_banner and has_banner %}
			{% if "banner_products_mobile.jpg" | has_custom_image %}
				<div class="d-md-none row">
					{% if settings.banner_products_link %}<a class="item-banner" href="{{ settings.banner_products_link }}" title="{{ 'Banner de' | translate }} {{ store.name }}">{% endif %}
						<img class="w-100 d-block d-md-none lazyautosizes lazyload blur-up-big" src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ "banner_products_mobile.jpg"| static_url | settings_image_url('1080p') }}" data-sizes="auto" alt="{{ 'Banner de' | translate }} {{ store.name }}"/>
					{% if settings.banner_products_link %}</a>{% endif %}
				</div>
			{% endif %}
			<div class="row">
				<div class="promo-products col-12 d-flex">
					<div class="d-none d-md-block col-banner col-grid {{ columns_desktop_class }} mt-3 position-relative">
						{% if settings.banner_products_link %}<a class="item-banner" href="{{ settings.banner_products_link }}" title="{{ 'Banner de' | translate }} {{ store.name }}">{% endif %}
							<img class="lazyautosizes lazyload blur-up-big" src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ "banner_products.jpg"| static_url | settings_image_url('1080p') }}" data-sizes="auto" alt="{{ 'Banner de' | translate }} {{ store.name }}"/>
						{% if settings.banner_products_link %}</a>{% endif %}
					</div>
					<div class="js-swiper-promos swiper pt-3">
						<div class="swiper-wrapper swiper-products-slider flex-nowrap">
						{% for product in sections_products %}
							{% include 'snipplets/grid/item.tpl' with {'slide_item': true, 'promo_products': true, 'section_columns_mobile': section_columns_mobile, 'section_columns_desktop': columns_desktop} %}
						{% endfor %}
						</div>             
					</div>
					{% if not settings.banner_products_title %}
						<div class="js-swiper-promos-prev swiper-button-prev swiper-button-prev-inside d-none d-md-block">
							<svg class="icon-inline icon-lg icon-flip-horizontal"><use xlink:href="#chevron"/></svg>
						</div>
						<div class="js-swiper-promos-next swiper-button-next swiper-button-next-inside d-none d-md-block">
							<svg class="icon-inline icon-lg"><use xlink:href="#chevron"/></svg>
						</div>
					{% endif %}
				</div> 
			</div>            
		{% elseif inner_content %}
		<div class="row">
			{% if settings.banner_products_box_title or settings.banner_products_description or settings.banner_products_button_text %}
			<div class="col-12 col-lg d-lg-flex flex-column align-items-center justify-content-center">
				<div class="text pt-3 p-lg-1 mb-lg-0 row">
					{% if settings.banner_products_box_title or settings.banner_products_description %}
					<div class="col-8 col-lg-12">
						<h3 class="mb-0">{{ settings.banner_products_box_title }}</h3>
						<p class="m-sm-0 mb-0 mb-lg-3">{{ settings.banner_products_description }}</p>
					</div>
					{% endif %}
					{% if settings.banner_products_button_text and settings.banner_products_button_url %}
					<div class="col-4 col-lg-12 d-flex d-lg-inline-block flex-column align-items-stretch justify-content-center">
						<a href="{{ settings.banner_products_button_url }}" class="btn btn-primary btn-medium btn-promo p-2 px-3">{{ settings.banner_products_button_text }}</a>
					</div>
					{% endif %}
				</div>
			</div>
			{% endif %}
			<div class="col-12 pr-0 px-md-3 p-lg-3 py-3 {% if settings.banner_products_box_title or settings.banner_products_description or settings.banner_products_button_text %}col-lg-10{% else %}col-lg-12{% endif %} promo-products">
				<div class="js-swiper-promos swiper">
					<div class="swiper-wrapper swiper-products-slider flex-nowrap">
					{% for product in sections_products %}
						{% include 'snipplets/grid/item.tpl' with {'slide_item': true, 'promo_products': true, 'section_columns_mobile': section_columns_mobile} %}
					{% endfor %}
					</div>
					{% if settings.banner_products_pagination and sections_products | length > columns_desktop %}
						<div class="js-swiper-promos-pagination mt-2"></div>
					{% endif %}                  
				</div>
				{% if not settings.banner_products_title %}
					<div class="js-swiper-promos-prev swiper-button-prev swiper-button-prev-inside d-none d-md-block">
						<svg class="icon-inline icon-lg icon-flip-horizontal"><use xlink:href="#chevron"/></svg>
					</div>
					<div class="js-swiper-promos-next swiper-button-next swiper-button-next-inside d-none d-md-block">
						<svg class="icon-inline icon-lg"><use xlink:href="#chevron"/></svg>
					</div>
				{% endif %}
			</div>
		</div>             
		{% endif %}           
	</div>
	{% if settings.banner_products_pagination and sections_products | length > columns_desktop %}
		<div class="js-swiper-promos-pagination w-100 mt-2"></div>
	{% endif %}    
</section>
{% endif %}