<section class="home-testimonials section-home" data-store="home-testimonials">
        
	<div class="container">
		<div class="section-title {% if settings.section_title_uppercase %}section-title-uppercase{% endif %} mx-auto row">
			<div class="col-12 text-center">
				<h2 class="text-heading mb-0">{{ 'Testimonios' | translate }}</h2>
			</div>
		</div>
	</div>
	
	<div class="container position-relative">
		<div class="js-home-testimonials-demo swiper swiper-container">
			<div class="swiper-wrapper">
				{% for i in 1..4 %}
				<div class="testimonial-swiper swiper-slide slide-container">
					<div class="testimonial">
						<div class="testimonial-image d-flex align-items-center justify-content-center">
							<svg class="icon-inline icon-3x opacity-30"><use xlink:href="#user"/></svg>
						</div>
						<div class="testimonial-stars">
							<svg class="icon-inline icon-lg fill-star"><use xlink:href="#star"/></svg>
							<svg class="icon-inline icon-lg fill-star"><use xlink:href="#star"/></svg>
							<svg class="icon-inline icon-lg fill-star"><use xlink:href="#star"/></svg>
							<svg class="icon-inline icon-lg fill-star"><use xlink:href="#star"/></svg>
							<svg class="icon-inline icon-lg fill-star"><use xlink:href="#star"/></svg>
						</div>
						<p>
							{{ 'Este es un testimonio de ejemplo. Usá este módulo para mostrar pruebas sociales a tus clientes y potenciar tus ventas.' | translate }}
						</p>
						<div class="testimonial-title h5">
							{{ 'Nombre de la persona' | translate }}
						</div>
					</div>
				</div>
				{% endfor %}
			</div>
		</div>
		<div class="js-swiper-testimonials-demo-prev swiper-button-prev d-none d-md-block svg-icon-secondary">
			<svg class="icon-inline icon-lg icon-flip-horizontal"><use xlink:href="#chevron"/></svg>
		</div>
		<div class="js-swiper-testimonials-demo-next swiper-button-next d-none d-md-block svg-icon-secondary">
			<svg class="icon-inline icon-lg"><use xlink:href="#chevron"/></svg>
		</div>
		<div class="js-testimonials-demo-pagination d-block d-md-none text-center"></div>
	</div>
</section>