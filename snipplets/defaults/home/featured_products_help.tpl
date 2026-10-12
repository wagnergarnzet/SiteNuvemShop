{# Products featured that work as examples #}

<section class="section-featured-home section-home" data-store="home-products-{{ section_id }}">
	<div class="container">
		<div class="row">
			<div class="col-12 pr-0 pr-md-3">

				<div class="js-products-{{ section_id }}-title section-title {% if settings.section_title_uppercase %}section-title-uppercase{% endif %} mx-auto row">
					<div class="col-12 text-center">
						<h2 class="text-heading mb-0">{{ products_title }}</h2>
					</div>
				</div>
				<div class="js-swiper-featured-demo swiper-container swiper-products">
					<div class="swiper-wrapper swiper-products-slider flex-nowrap row row-grid">
						{% include 'snipplets/defaults/help_item.tpl' with {'slide_item': true, 'help_item_1': true, 'section_columns_desktop': 4, 'section_columns_mobile': 2}  %}
						{% include 'snipplets/defaults/help_item.tpl' with {'slide_item': true, 'help_item_2': true, 'section_columns_desktop': 4, 'section_columns_mobile': 2}  %}
						{% include 'snipplets/defaults/help_item.tpl' with {'slide_item': true, 'help_item_3': true, 'section_columns_desktop': 4, 'section_columns_mobile': 2}  %}
						{% include 'snipplets/defaults/help_item.tpl' with {'slide_item': true, 'help_item_4': true, 'section_columns_desktop': 4, 'section_columns_mobile': 2}  %}
						{% include 'snipplets/defaults/help_item.tpl' with {'slide_item': true, 'help_item_5': true, 'section_columns_desktop': 4, 'section_columns_mobile': 2}  %}
						{% include 'snipplets/defaults/help_item.tpl' with {'slide_item': true, 'help_item_6': true, 'section_columns_desktop': 4, 'section_columns_mobile': 2}  %}
					</div>
				</div>
				<div class="js-swiper-featured-demo-prev swiper-button-prev swiper-button-outside d-none d-md-block svg-icon-text">
					<svg class="icon-inline icon-lg icon-flip-horizontal"><use xlink:href="#chevron"/></svg>
				</div>
				<div class="js-swiper-featured-demo-next swiper-button-next swiper-button-outside d-none d-md-block svg-icon-text">
					<svg class="icon-inline icon-lg"><use xlink:href="#chevron"/></svg>
				</div>
			</div>
		</div>
	</div>
</section>