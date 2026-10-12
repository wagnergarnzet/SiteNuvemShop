{# Informative banners that work as examples #}

<section class="section-home section-informative-banners position-relative" data-store="banner-services">
	<div class="js-informative-banners-demo swiper banner-services  services-row services-md-row">
		<div class="swiper-wrapper wrapper">
			<div class="swiper-slide service-item">
				<div class="service-image">
					<svg class="icon-inline service-icon"><use xlink:href="#truck"/></svg>
				</div>
				<div class="service-text">
					<div class="service-title mb-1">{{ 'Envíos y entrega' | translate }}</div>
					<p class="m-0">{{ 'Envios a todo el país' | translate }}</p>
				</div>
			</div>
			<div class="swiper-slide service-item">
				<div class="service-image">
					<svg class="icon-inline service-icon"><use xlink:href="#credit-card"/></svg>
				</div>
				<div class="service-text">
					<div class="service-title mb-1">{{ 'Medios de pago' | translate }}</div>
					<p class="m-0">{{ 'Pagá con crédito y débito' | translate }}</p>
				</div>
			</div>
			<div class="swiper-slide service-item">
				<div class="service-image">
					<svg class="icon-inline service-icon"><use xlink:href="#security"/></svg>
				</div>
				<div class="service-text">
					<div class="service-title mb-1">{{ 'Seguridad' | translate }}</div>
					<p class="m-0">{{ 'Sitio 100% seguro' | translate }}</p>
				</div>
			</div>
			<div class="swiper-slide service-item">
				<div class="service-image">
					<svg class="icon-inline service-icon"><use xlink:href="#returns"/></svg>
				</div>
				<div class="service-text">
					<div class="service-title mb-1">{{ 'Cambios y devoluciones' | translate }}</div>
					<p class="m-0">{{ 'en hasta 7 días' | translate }}</p>
				</div>
			</div>
		</div>
		<div class="js-informative-banners-demo-prev swiper-button-prev svg-icon-secondary d-flex d-md-none">
			<svg class="icon-inline icon-lg icon-flip-horizontal"><use xlink:href="#chevron"/></svg>
		</div>
		<div class="js-informative-banners-demo-next swiper-button-next svg-icon-secondary d-flex d-md-none">
			<svg class="icon-inline icon-lg"><use xlink:href="#chevron"/></svg>
		</div>
	</div>
	<div class="placeholder-overlay transition-soft">
		<div class="placeholder-info">
			<svg class="icon-inline icon-3x"><use xlink:href="#edit"/></svg>
			<div class="placeholder-description font-small-xs">
				{{ "Podés mostrar tu información desde" | translate }} <strong>"{{ "Información de envíos, pagos y compra" | translate }}"</strong>
			</div>
			{% if not params.preview %}
				<a href="{{ admin_link }}#instatheme=pagina-de-inicio" class="btn-primary btn btn-small placeholder-button">{{ "Editar" | translate }}</a>
			{% endif %}
		</div>
	</div>
</section>