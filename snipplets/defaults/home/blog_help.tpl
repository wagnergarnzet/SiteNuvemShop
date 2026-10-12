{# Blog that work as examples #}

{% set banner_view_box = '0 0 1440 770' %}

<section class="section-home section-blog-home position-relative" data-store="home-blog-posts">
    <div class="container">
        <div class="section-title {% if settings.section_title_uppercase %}section-title-uppercase{% endif %} mx-auto mb-3 row">
            <div class="col-12 text-center">
                <h2 class="text-heading mb-0">{{ "Publicaciones del blog" | translate }}</h2>
            </div>
        </div>
        <div class="row">
            {% for post in 1..4 %}
                <div class="col-12 col-md-3 mb-4 mb-md-0">
                    <div class="home-post-image mb-3">
                        <div class="home-post-image">
                            <svg viewBox='{{ banner_view_box }}'><use xlink:href="#slider-slide-placeholder"/></svg>
                        </div>
                    </div>
                    <div class="textpost-text">
                        <h3 class="mb-2">
                            {{ "Título de la publicación" | translate }}
                        </h3>
                    </div>
                    <p>{{ 'Usá esta sección para contar las novedades en tu tienda' | translate }}</p>
                    <a class="btn btn-blog btn-small btn-secondary d-inline-block" href="#" title="{{ 'Leer más' | translate }}">
                        {{ 'Leer más' | translate }}
                    </a>
                </div>
            {% endfor %}
        </div>
    </div>
    {% if not params.preview %}
		<div class="placeholder-overlay transition-soft">
			<div class="placeholder-info">
				<svg class="icon-inline icon-3x"><use xlink:href="#edit"/></svg>
				<div class="placeholder-description font-small-xs">
					{{ "Podés mostrar tus últimas novedades desde" | translate }} <strong>"{{ "Publicaciones del blog" | translate }}"</strong>
				</div>
				<a href="{{ admin_link }}#instatheme=pagina-de-inicio" class="btn-primary btn btn-small placeholder-button">{{ "Editar" | translate }}</a>
			</div>
		</div>
	{% endif %}
</section>