{% embed "snipplets/page-header.tpl" %}
	{% block page_header_text %}{% if product %}{{ "Consultar por el producto" | translate }}{% else %}{{ "Contacto" | translate }}{% endif %}{% endblock page_header_text %}
{% endembed %}

<section class="contact-page {% if product %}contact-product-page pt-3{% endif %}">
	<div class="container">
		<div class="row">
			<div class="col-md-8">
				{% if store.contact_intro %}
					<p class="h5">{{ store.contact_intro }}</p>
				{% endif %}
			</div>
		</div>
		<div class="row">
			<div class="col-md-8">
				{% if product %}  
					<div class="card d-block d-md-none"> 
						<div class="card-header h4">{{ "Estás consultando por el producto:" | translate }}</div>
						<div class="card-body">
							<div class="row no-gutters">
								<div class="col-5 col-md-4">
									<img class="img-fluid" src="{{ product.featured_image | product_image_url('thumb') }}" title="{{ product.name }}" alt="{{ product.name }}" />
								</div>
								<div class="col-7 col-md-8">
									<p class="h5">{{ product.name | a_tag(product.url) }}</p>
								</div>
							</div>
						</div>
					</div>
				{% endif %}
				{% if contact %}
					{% if contact.success %}
						<div class="alert alert-success">{{ "¡Gracias por contactarnos! Vamos a responderte apenas veamos tu mensaje." | translate }}</div>
					{% else %}
						<div class="alert alert-danger">{{ "Necesitamos tu nombre y un email para poder responderte." | translate }}</div>
					{% endif %}
				{% endif %}	
				
				{% embed "snipplets/forms/form.tpl" with{form_id: 'contact-form', form_custom_class: 'js-winnie-pooh-form mb-4', form_action: '/winnie-pooh', submit_name: 'contact', submit_custom_class: 'd-block w-100 mt-2', submit_text: 'Enviar mensaje' | translate, data_store: 'contact-form'} %}
					{% block form_body %}

						{# Hidden inputs used to send attributes #}

						<div class="winnie-pooh hidden">
							<label for="winnie-pooh">{{ "No completar este campo" | translate }}:</label>
							<input type="text" id="winnie-pooh" name="winnie-pooh">
						</div>
						<input type="hidden" value="{{ product.id }}" name="product"/>
						<input type="hidden" name="type" value="contact" />

						{# Name input #}

						{% embed "snipplets/forms/form-input.tpl" with{input_for: 'name', type_text: true, input_name: 'name', input_id: 'name', input_label_text: 'Nombre' | translate } %}
						{% endembed %}

						<div class="row">
							{# Email input #}

							{% embed "snipplets/forms/form-input.tpl" with{input_for: 'email', type_email: true, input_name: 'email', input_id: 'email', input_group_custom_class: 'col-md-6 pr-md-1', input_label_text: 'Email' | translate } %}
							{% endembed %}

							{# Phone input #}

							{% embed "snipplets/forms/form-input.tpl" with{input_for: 'phone', type_tel: true, input_name: 'phone', input_id: 'phone', input_group_custom_class: 'col-md-6', input_label_text: 'Teléfono' | translate } %}
							{% endembed %}
						</div>

						{# Message textarea #}

						{% embed "snipplets/forms/form-input.tpl" with{text_area: true, input_for: 'message', input_name: 'message', input_id: 'message', input_rows: '7', input_label_text: 'Mensaje' | translate } %}
						{% endembed %}

					{% endblock %}
				{% endembed %}
			</div>
			<div class="col-md-4">
				{% if product %}  
					<div class="card d-none d-md-block"> 
						<div class="card-header h4">{{ "Estás consultando por el producto:" | translate }}</div>
						<div class="card-body">
							<div class="row no-gutters">
								<div class="col-5 col-md-4">
									<img class="img-fluid" src="{{ product.featured_image | product_image_url('thumb') }}" title="{{ product.name }}" alt="{{ product.name }}" />
								</div>
								<div class="col-7 col-md-8">
									<p class="h5">{{ product.name | a_tag(product.url) }}</p>
								</div>
							</div>
						</div>
					</div>
				{% endif %}	
				{% include "snipplets/contact-links.tpl" with {contact_page: true, titles: true} %}
				<div class="d-none d-md-flex justify-content-center">
					{% include "snipplets/social/social-links.tpl" %}
				</div>
			</div>
			{% set show_map = store.address and settings.show_map_on_contact %}
			{% if show_map %}
				<div class="col-md-6">
					<iframe id="gmap_canvas" class="map" src="https://maps.google.com/maps?q={{ store.address }}&t=&z=13&ie=UTF8&iwloc=&output=embed" frameborder="0" scrolling="no" marginheight="0" marginwidth="0">
					</iframe>
				</div>
			{% endif %}
		</div>
	</div>
</section>