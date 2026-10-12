{# Slider that work as example #}

{% set slide_view_box = '0 0 1440 770' %}

<section class="js-home-slider-container" data-store="home-slider">
	<div class="section-slider position-relative">
		{% if not settings.slider_full %}
			<div class="container">
		{% endif %}
		<div class="js-home-empty-slider swiper-container{% if not settings.slider_full %} mt-4{% endif %}">
			<div class="swiper-wrapper">
				<div class="swiper-slide slide-container">
					<svg viewBox='{{ slide_view_box }}'><use xlink:href="#slider-slide-placeholder"/></svg>
				</div>
				<div class="swiper-slide slide-container">
					<svg viewBox='{{ slide_view_box }}'><use xlink:href="#slider-slide-placeholder"/></svg>
				</div>
				<div class="swiper-slide slide-container">
					<svg viewBox='{{ slide_view_box }}'><use xlink:href="#slider-slide-placeholder"/></svg>
				</div>
			</div>
			<div class="placeholder-overlay placeholder-slider transition-soft">
				<div class="placeholder-info">
					<svg class="icon-inline icon-3x"><use xlink:href="#edit"/></svg>
					<div class="placeholder-description font-small-xs">
						{{ "Podés subir imágenes principales desde" | translate }} <strong>"{{ "Carrusel de imágenes" | translate }}"</strong>
					</div>
					{% if not params.preview %}
						<a href="{{ admin_link }}#instatheme=pagina-de-inicio" class="btn-primary btn btn-small placeholder-button">{{ "Editar" | translate }}</a>
					{% endif %}
				</div>
			</div>
			<div class="js-swiper-empty-home-pagination swiper-pagination swiper-pagination-bullets d-block my-3"></div>
		</div>
		{% if not settings.slider_full %}
			</div>
		{% endif %}
	</div>
</section>