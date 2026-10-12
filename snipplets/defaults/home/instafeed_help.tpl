{# Instagram feed that work as examples #}

<section class="section-instafeed-home section-instafeed section-home position-relative overflow-none" data-store="home-instagram-feed">
	<div class="container">
		<div class="row align-items-center">
			<div class="col-md-3 p-0 pl-md-3">
				<div class="instafeed-intro text-center d-flex flex-column justify-content-center align-items-center">
					<span>{{ "Seguínos en Instagram" | translate }}</span>
					<div class="instafeed-title">@instagram</div>
				</div>
			</div>
			<div class="col-md-9">
				<div id="instafeed" class="row row-grid">
					{% include 'snipplets/defaults/help_instagram.tpl' with {'help_item_1': true} %}
					{% include 'snipplets/defaults/help_instagram.tpl' with {'help_item_2': true} %}
					{% include 'snipplets/defaults/help_instagram.tpl' with {'help_item_1': true} %}
					{% include 'snipplets/defaults/help_instagram.tpl' with {'help_item_2': true} %}
				</div>
			</div>
		</div>
	</div>
	<div class="placeholder-overlay transition-soft">
		<div class="placeholder-info">
			<svg class="icon-inline icon-3x"><use xlink:href="#edit"/></svg>
			<div class="placeholder-description font-small-xs">
				{{ "Podés mostrar tus fotos desde" | translate }} <strong>"{{ "Publicaciones de Instagram" | translate }}"</strong>
			</div>
			{% if not params.preview %}
				<a href="{{ admin_link }}#instatheme=redes-sociales" class="btn-primary btn btn-small placeholder-button">{{ "Editar" | translate }}</a>
			{% endif %}
		</div>
	</div>
</section>