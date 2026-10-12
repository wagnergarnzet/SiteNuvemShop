{# Promotional banners that work as examples #}

{% set slide_view_box = '0 0 1440 770' %}

<section class="section-banners-home section-home" data-store="home-banner-promotional">
	<div class="container">
		<div class="row">
			<div class="col-12">
				<div class="row px-2">
					{% for i in 1..3 %}
						<div class="col-grid col-md-4">
							<div class="textbanner">
								<div class="textbanner-image p-0">
									<svg viewBox='{{ slide_view_box }}'><use xlink:href="#slider-slide-placeholder"/></svg>
								</div>
								<div class="textbanner-text text-center over-image">
									<div class="h4 h1-md mb-1">{{ "Promoción" | translate }}</div>
								</div>
								<div class="placeholder-overlay transition-soft">
									<div class="placeholder-info">
										<svg class="icon-inline icon-3x"><use xlink:href="#edit"/></svg>
										<div class="placeholder-description font-small-xs">
											{{ "Podés mostrar tus promociones desde" | translate }} <strong>"{{ "Banners promocionales" | translate }}"</strong>
										</div>
										{% if not params.preview %}
											<a href="{{ admin_link }}#instatheme=pagina-de-inicio" class="btn-primary btn btn-small placeholder-button">{{ "Editar" | translate }}</a>
										{% endif %}
									</div>
								</div>
							</div>
						</div>
					{% endfor %}
				</div>
			</div>
		</div>
	</div>
</section>