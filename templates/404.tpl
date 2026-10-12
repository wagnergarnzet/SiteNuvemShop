{# Only remove this if you want to take away the theme onboarding advices #}
{% set show_help = not has_products %}

{# Here we will add an example as a help, you can delete this after you upload your products #}
{% if show_help %}
	<div id="product-example">
		{% snipplet 'defaults/show_help_product.tpl' %}
	</div>
{% else %}
<section id="404">
	<div class="container">
		<div class="row">
			<div class="col-12 text-center py-5">
				<svg class="icon-inline icon-5x mx-auto mb-2"><use xlink:href="#alert"/></svg>
				<h1 class="h2">{{ '¡Ups! No encontramos lo que buscabas' | translate }}</h1>
				<p class="my-4">{{ 'El contenido que buscás puede no estar disponible.</br>Asegurate de que escribiste la dirección correctamente.' | translate }}</p>
			</div>
		</div>
		{% set related_products = sections.primary.products | take(4) | shuffle %}
		{% if related_products | length > 1 %}
			<div class="row">
				<div class="col-12 text-center">
					<h3 class="mb-2 font-weight-normal">{{ "Quizás te interesen los siguientes productos" | translate }}</h3>
				</div>
			</div>
			<div class="form-row mt-3">
				{% for related in related_products %}
					{% include 'snipplets/grid/item.tpl' with {product : related} %}
				{% endfor %}
			</div>
		{% endif %}
	</div>
</section>
{% endif %}