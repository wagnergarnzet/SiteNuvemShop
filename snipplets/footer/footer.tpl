{% set has_social_network = store.facebook or store.twitter or store.pinterest or store.instagram or store.tiktok or store.youtube %}
{% set has_footer_contact_info = (store.whatsapp or store.phone or store.email or store.address or store.blog) and settings.footer_contact_show %} 

{% set has_footer_menu = settings.footer_menu and settings.footer_menu_show %}
{% set has_footer_menu_secondary = settings.footer_menu_secondary and settings.footer_menu_secondary_show %}
{% set has_footer_about = settings.footer_about_show and (settings.footer_about_title or settings.footer_about_description) %}
{% set has_payment_logos = settings.payments %}
{% set has_shipping_logos = settings.shipping %}
{% set has_shipping_payment_logos = has_payment_logos or has_shipping_logos %}

{% set has_footer_logo = "footer_logo.png" | has_custom_image %}
{% set has_shipping_additional = settings.shipping_moto or settings.shipping_transport or settings.shipping_person %}

{% set has_seal_logos = store.afip or ebit or settings.custom_seal_code or ("seal_img.jpg" | has_custom_image) %}
{% set show_help = not has_products and not has_social_network %}
{% set has_newsletter = settings.news_show %}

{{ component('nubesdk-slot', { type: "before_footer" }) }}

<footer class="js-footer js-hide-footer-while-scrolling main-footer {% if template == 'home' %}footer-home{% endif %} {% if settings.institutional_on_pages %}footer-institutional{% endif %} {% if settings.footer_colors %}footer-colors{% endif %} display-when-content-ready" data-store="footer">
	{% if settings.footer_background or settings.footer_background_mobile %}
		<div class="footer-background">
	{% endif %}
	{% if settings.footer_layout == "style2" %}
	<div class="container">
		<div class="row footer-block">
			{% if template != 'password' %}

				{% if settings.footer_layout == "style2" %}

					{# Logo and about #}
					<div class="col-md">
						{% if "footer_logo.png" | has_custom_image %}
							<div class="logo-img-container">
								<img src="{{ 'footer_logo.png' | static_url }}" data-src="{{ "footer_logo.png" | static_url }}" class="logo-img" alt="{{ store.name }}"/>
							</div>
						{% else %}

							{% include "snipplets/header/header-logo.tpl" with {fixed_header: true} %}

						{% endif %}
						{% if has_footer_about %}
							{% if settings.footer_about_title %}
								<div class="h4 mb-3">{{ settings.footer_about_title }}</div>
							{% endif %}
							{% if settings.footer_about_description %}
								<p class="footer-about mb-4 mb-md-0">{{ settings.footer_about_description }}</p>
							{% endif %}
						{% endif %}
					</div>

					{# Foot Nav #}
					{% if has_footer_menu %}
						<div class="col-12 col-md-2">
							{% if settings.footer_menu_title %}
								<div class="h4 mb-3">{{ settings.footer_menu_title }}</div>
							{% endif %}
							{% include "snipplets/navigation/navigation-foot.tpl" %}
						</div>
					{% endif %}

					{% if settings.footer_menu_secondary_show %}
						<div class="col-12 col-md">
							{% if settings.footer_menu_secondary_title %}
								<div class="h4 mb-3">{{ settings.footer_menu_secondary_title }}</div>
							{% endif %}
							{% include "snipplets/navigation/navigation-foot-secondary.tpl" %}
						</div>
					{% endif %}

					{# Contact #}
					{% if has_footer_contact_info %}
						<div class="col-12 col-md">
						{% if settings.footer_contact_title %}
							<div class="h4 mb-3">{{ settings.footer_contact_title }}</div>
						{% endif %}
						{% include "snipplets/contact-links.tpl" %}
						</div>
					{% endif %}

					{# Newsletter #}
					{% if settings.news_show %}
						<div class="col-md">
							{% include "snipplets/newsletter.tpl" %}
						</div>
					{% endif %}

				{% else %}


					{# Logo Left #}
					<div class="col-md">
						{% if "footer_logo.png" | has_custom_image %}
							<div class="logo-img-container">

								<img src="{{ 'footer_logo.png' | static_url }}" data-src="{{ "footer_logo.png" | static_url }}" class="logo-img" alt="{{ store.name }}"/>

							</div>
						{% else %}

							{% include "snipplets/header/header-logo.tpl" with {fixed_header: true} %}

						{% endif %}
					</div>

					{# About #}
					{% if has_footer_about %}
						<div class="col-md">
							{% if settings.footer_about_title %}
								<div class="h4 mb-3">{{ settings.footer_about_title }}</div>
							{% endif %}
							{% if settings.footer_about_description %}
								<p class="footer-about mb-4 mb-md-0">{{ settings.footer_about_description }}</p>
							{% endif %}
						</div>
					{% endif %}

					{# Foot Nav #}
					{% if has_footer_menu %}
						<div class="col-12 col-md">
							{% if settings.footer_menu_title %}
								<div class="h4 mb-3">{{ settings.footer_menu_title }}</div>
							{% endif %}
							{% include "snipplets/navigation/navigation-foot.tpl" %}
						</div>
					{% endif %}

					{% if settings.footer_menu_secondary_show %}
						<div class="col-12 col-md">
							{% if settings.footer_menu_secondary_title %}
								<div class="h4 mb-3">{{ settings.footer_menu_secondary_title }}</div>
							{% endif %}
							{% include "snipplets/navigation/navigation-foot-secondary.tpl" %}
						</div>
					{% endif %}

					{# Contact #}
					{% if has_footer_contact_info %}
						<div class="col-12 col-md">
						{% if settings.footer_contact_title %}
							<div class="h4 mb-3">{{ settings.footer_contact_title }}</div>
						{% endif %}
						{% include "snipplets/contact-links.tpl" %}
						</div>
					{% endif %}

				{% endif %}
			{% endif %}
		</div>
	</div>
	{% elseif settings.footer_layout == "style3" %}
	<div class="footer-form text-center text-md-left">
		<div class="container">
			<div class="row text-center justify-content-center">

				{% if settings.news_show %}
					<div class="col-md-8">

						{# Newsletter #}
						{% if settings.news_show %}
							{% include "snipplets/newsletter.tpl" with {inline_form: true} %}
						{% endif %}

					</div>
				{% endif %}

			</div>
		</div>
	</div>
	{% elseif settings.footer_layout == "style4" %}
	<div class="footer-form text-center text-md-left">
		<div class="container">
			<div class="row text-center justify-content-center">

				{% if settings.news_show %}
					<div class="col-10 col-md">

						{# Newsletter #}
						{% if settings.news_show %}
							{% include "snipplets/newsletter.tpl" with {inline_form: true, inline_block: true} %}
						{% endif %}

					</div>
				{% endif %}

			</div>
		</div>
	</div>
	{% endif %}
	
	{% if template != 'password' %}

		{% if settings.footer_layout == "style3" or settings.footer_layout == "style4" %}
		<div class="container">
			<div class="row justify-content-between footer-block footer-payments-shipping-logos">

				{% if has_footer_about or has_social_network %}
					<div class="col-12 col-md-3">
						{# Logo #}
						{% if "footer_logo.png" | has_custom_image %}
							<div class="logo-img-container">
								<img src="{{ 'footer_logo.png' | static_url }}" data-src="{{ "footer_logo.png" | static_url }}" class="logo-img" alt="{{ store.name }}"/>
							</div>
						{% else %}
							<div class="mb-3">
								{% include "snipplets/header/header-logo.tpl" with {fixed_header: true} %}
							</div>
						{% endif %}

						{# About #}
						{% if has_footer_about %}
							{% if settings.footer_about_title %}
								<div class="h4 mb-3">{{ settings.footer_about_title }}</div>
							{% endif %}
							{% if settings.footer_about_description %}
								<p class="footer-about mb-4 mb-md-0">{{ settings.footer_about_description }}</p>
							{% endif %}
						{% endif %}
						
						{# Social #}
						{% if has_social_network %}
							<div class="footer-social pt-2">
								{% include "snipplets/social/social-footer.tpl" %}
							</div>
						{% endif %}
					</div>
				{% endif %}

				{# Foot Nav #}
				{% if has_footer_menu %}
					<div class="col-12 col-md">
						{% if settings.footer_menu_title %}
							<div class="h4 mb-3">{{ settings.footer_menu_title }}</div>
						{% endif %}
						{% include "snipplets/navigation/navigation-foot.tpl" %}
					</div>
				{% endif %}

				{% if settings.footer_menu_secondary_show %}
					<div class="col-12 col-md">
						{% if settings.footer_menu_secondary_title %}
							<div class="h4 mb-3">{{ settings.footer_menu_secondary_title }}</div>
						{% endif %}
						{% include "snipplets/navigation/navigation-foot-secondary.tpl" %}
					</div>
				{% endif %}

				{# Contact #}
				{% if has_footer_contact_info %}
					<div class="col-12 col-md">
					{% if settings.footer_contact_title %}
						<div class="h4 mb-3">{{ settings.footer_contact_title }}</div>
					{% endif %}
					{% include "snipplets/contact-links.tpl" %}
					</div>
				{% endif %}

				{% if settings.payments_show or has_seal_logos or settings.google_security %}
					<div class="col-md-3">
						{% if settings.payments_show %}
							<div class="col-md mb-4 {% if has_seal_logos or settings.google_security %}mb-md-2{% else %}mb-md-0{% endif %} footer-payments">
								<div class="h4 mb-3">{{ "Medios de pago" | translate }}</div>
								<div class="logos">
									{% if settings.payments_logos == "custom" %}
										{% include "snipplets/logos-icons.tpl" with {'custom_payments': true} %}
									{% else %}
										{% include "snipplets/logos-icons.tpl" with {'payments': true} %}
									{% endif %}
								</div>
							</div>
						{% endif %}
						{# AFIP - EBIT - Custom Seal #}
						{% if has_seal_logos or settings.google_security %}
							<div class="col-md-auto mb-0 security-logos">
								<div class="h4 mb-3">{{ 'Seguridad' | translate }}</div>
								<div class="d-flex align-items-center justify-content-center justify-content-md-start">
									{% if settings.google_security %}
										<div class="footer-logo google-seal">
											<a href="https://transparencyreport.google.com/safe-browsing/search?url={{ store.url }}" target="_blank">
												{% if settings.security_color == 'white' %}
													<img src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ "images/google-safe-white.png" | static_url }}" class="custom-seal-img lazyload" alt="{{ 'Sello de' | translate }} {{ store.name }}"/>
												{% elseif settings.security_color == 'mono' %}
													<img src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ "images/google-safe-mono.png" | static_url }}" class="custom-seal-img lazyload" alt="{{ 'Sello de' | translate }} {{ store.name }}"/>
												{% else %}
													<img src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ "images/google-safe-color.png" | static_url }}" class="custom-seal-img lazyload" alt="{{ 'Sello de' | translate }} {{ store.name }}"/>
												{% endif %}
											</a>
										</div>
									{% endif %}
									{% if store.afip or ebit %}
										{% if store.afip %}
											<div class="footer-logo afip seal-afip p-1">
												{{ store.afip | raw }}
											</div>
										{% endif %}
										{% if ebit %}
											<div class="footer-logo ebit seal-ebit p-1">
												{{ ebit }}
											</div>
										{% endif %}
									{% endif %}
									{% if "seal_img.jpg" | has_custom_image or settings.custom_seal_code %}
										{% if "seal_img.jpg" | has_custom_image %}
											<div class="footer-logo custom-seal p-1">
												{% if settings.seal_url != '' %}
													<a href="{{ settings.seal_url }}" target="_blank">
												{% endif %}
													<img src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ "seal_img.jpg" | static_url }}" class="custom-seal-img lazyload" alt="{{ 'Sello de' | translate }} {{ store.name }}"/>
												{% if settings.seal_url != '' %}
													</a>
												{% endif %}
											</div>
										{% endif %}
										{% if settings.custom_seal_code %}
											<div class="custom-seal custom-seal-code p-1">
												{{ settings.custom_seal_code | raw }}
											</div>
										{% endif %}
									{% endif %}
								</div>
							</div>
						{% endif %}
					</div>
				{% endif %}

			</div>
		</div>
		{% elseif settings.footer_layout == "style1" %}
			<div class="footer-form text-center text-md-left">
				<div class="container">
					<div class="row {% if not settings.news_show %}justify-content-center{% endif %}">
						<div class="col-12 col-lg-auto d-flex justify-content-center align-items-center">
							{% if "footer_logo.png" | has_custom_image %}
								<div class="logo-img-container">

									<img src="{{ 'footer_logo.png' | static_url }}" data-src="{{ "footer_logo.png" | static_url }}" class="logo-img" alt="{{ store.name }}"/>

								</div>
							{% else %}

								{% include "snipplets/header/header-logo.tpl" with {fixed_header: true} %}

							{% endif %}
						</div>

						{% if has_social_network %}

							<div class="col-12 col-lg-auto col-social d-flex align-items-center justify-content-center py-3">
								{# Social #}
								{% if has_social_network %}
									{% include "snipplets/social/social-footer.tpl" %}
								{% endif %}
							</div>

						{% endif %}
			
						{% if settings.news_show %}
							<div class="col-10 offset-1 offset-lg-0 col-lg text-center text-lg-left">
								{% include "snipplets/newsletter.tpl" with {inline_form: true} %}
							</div>
						{% endif %}

					</div>
				</div>
			</div>
		{% endif %}
		{% if settings.footer_layout == "style1" %}
			<div class="footer-menus container">
				<div class="row footer-block justify-content-between">
					{# About #}
					{% if has_footer_about %}
						<div class="col-12 col-md-3">
							{% if settings.footer_about_title %}
								<div class="h4 mb-3">{{ settings.footer_about_title }}</div>
							{% endif %}
							{% if settings.footer_about_description %}
								<p class="footer-about mb-4 mb-md-0">{{ settings.footer_about_description }}</p>
							{% endif %}
						</div>
					{% endif %}

					{# Foot Nav #}
					{% if has_footer_menu %}
						<div class="col-12 {% if has_footer_contact_info or settings.footer_menu_secondary_show %}col-md-auto{% else %}col-md{% endif %}">
							{% if settings.footer_menu_title and has_footer_contact_info or settings.footer_menu_secondary_show %}
								<div class="h4 mb-3">{{ settings.footer_menu_title }}</div>
							{% endif %}
							{% if has_footer_contact_info or settings.footer_menu_secondary_show %}
								{% include "snipplets/navigation/navigation-foot.tpl" %}
							{% else %}
								{% include "snipplets/navigation/navigation-foot.tpl" with {inline_menu: true} %}
							{% endif %}
						</div>
					{% endif %}

					{% if settings.footer_menu_secondary_show %}
						<div class="col-12 col-md-auto">
							{% if settings.footer_menu_secondary_title %}
								<div class="h4 mb-3">{{ settings.footer_menu_secondary_title }}</div>
							{% endif %}
							{% include "snipplets/navigation/navigation-foot-secondary.tpl" %}
						</div>
					{% endif %}

					{# Contact #}
					{% if has_footer_contact_info %}
						<div class="col-12 col-md-3">
						{% if settings.footer_contact_title %}
							<div class="h4 mb-3">{{ settings.footer_contact_title }}</div>
						{% endif %}
						{% include "snipplets/contact-links.tpl" %}
						</div>
					{% endif %}
				</div>
			</div>
		{% endif %}
		{% if settings.footer_layout == "style2" or settings.footer_layout == "style1" %}
		{# Logos Payments and Shipping #}
		<div class="footer-payments-shipping-logos text-center text-md-left">
			<div class="container">
				<div class="row footer-block element-footer-line justify-content-between">
					{% if settings.payments_show %}
						<div class="col-md-{% if settings.payments_logos == "custom" %}auto{% else %}5{% endif %} mb-4 mb-md-0 footer-payments">
							<div class="h4 mb-3">{{ "Medios de pago" | translate }}</div>
							<div class="logos">
								{% if settings.payments_logos == "custom" %}
									{% include "snipplets/logos-icons.tpl" with {'custom_payments': true} %}
								{% else %}
									{% include "snipplets/logos-icons.tpl" with {'payments': true} %}
								{% endif %}
							</div>
						</div>
					{% endif %}
					{% if settings.shipping_show and (has_shipping_logos or has_shipping_additional) %}
						<div class="col-md-auto mb-4 mb-md-0 footer-shipping">
							<div class="h4 mb-3">{{ "Medios de envío" | translate }}</div>
							<div class="shipping-logos">
								{% if has_shipping_logos %}
                                    {% include "snipplets/logos-icons.tpl" with {'shipping': true} %}
                                {% endif %}
								{% if has_shipping_additional %}
									{% if settings.shipping_transport %}
										<img src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ "images/shipping-truck.jpg" | static_url }}" class="lazyload" title="{{ 'Transportadora' | translate }}" alt="{{ 'Transportadora' | translate }}"/>
									{% endif %}
									{% if settings.shipping_moto %}
										<img src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ "images/shipping-moto.jpg" | static_url }}" class="lazyload" title="{{ 'Moto' | translate }}" alt="{{ 'Moto' | translate }}"/>
									{% endif %}
									{% if settings.shipping_person %}
										<img src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ "images/shipping-person.jpg" | static_url }}" class="lazyload" title="{{ 'Entrega propia' | translate }}" alt="{{ 'Entrega propia' | translate }}"/>
									{% endif %}
								{% endif %}
							</div>
						</div>
					{% endif %}
					{# AFIP - EBIT - Custom Seal #}
					{% if has_seal_logos or settings.google_security %}
						<div class="col-md-auto mb-0 security-logos">
							<div class="h4 mb-3">Segurança</div>
							<div class="d-flex align-items-center justify-content-center justify-content-md-start">
								{% if settings.google_security %}
									<div class="footer-logo google-seal">
										<a href="https://transparencyreport.google.com/safe-browsing/search?url={{ store.url }}" target="_blank">
											{% if settings.security_color == 'white' %}
												<img src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ "images/google-safe-white.png" | static_url }}" class="custom-seal-img lazyload" alt="{{ 'Sello de' | translate }} {{ store.name }}"/>
											{% elseif settings.security_color == 'mono' %}
												<img src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ "images/google-safe-mono.png" | static_url }}" class="custom-seal-img lazyload" alt="{{ 'Sello de' | translate }} {{ store.name }}"/>
											{% else %}
												<img src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ "images/google-safe-color.png" | static_url }}" class="custom-seal-img lazyload" alt="{{ 'Sello de' | translate }} {{ store.name }}"/>
											{% endif %}
										</a>
									</div>
								{% endif %}
								{% if store.afip or ebit %}
									{% if store.afip %}
										<div class="footer-logo afip seal-afip p-1">
											{{ store.afip | raw }}
										</div>
									{% endif %}
									{% if ebit %}
										<div class="footer-logo ebit seal-ebit p-1">
											{{ ebit }}
										</div>
									{% endif %}
								{% endif %}
								{% if "seal_img.jpg" | has_custom_image or settings.custom_seal_code %}
									{% if "seal_img.jpg" | has_custom_image %}
										<div class="footer-logo custom-seal p-1">
											{% if settings.seal_url != '' %}
												<a href="{{ settings.seal_url }}" target="_blank">
											{% endif %}
												<img src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ "seal_img.jpg" | static_url }}" class="custom-seal-img lazyload" alt="{{ 'Sello de' | translate }} {{ store.name }}"/>
											{% if settings.seal_url != '' %}
												</a>
											{% endif %}
										</div>
									{% endif %}
									{% if settings.custom_seal_code %}
										<div class="custom-seal custom-seal-code p-1">
											{{ settings.custom_seal_code | raw }}
										</div>
									{% endif %}
								{% endif %}

								{{ component('nubesdk-slot', { type: "footer_seals" }) }}

							</div>
						</div>
					{% endif %}
				</div>	
			</div>
		</div>
		{% endif %}
	{% endif %}
	{% if settings.footer_layout == "style2" or settings.footer_layout == "style3" %}
		{% if has_social_network %}
			<div class="section-social footer-block block-bg{% if settings.footer_block == 'custom' %}-custom {% elseif settings.footer_block == 'brand' %}-brand {% elseif settings.footer_block == 'secondary' %}-secondary {% endif %} block-text{% if settings.footer_block_text == 'custom' %}-custom {% elseif settings.footer_block_text == 'brand' %}-brand {% elseif settings.footer_block_text == 'text' %}-text {% endif %}">
				<div class="container">
					<div class="row">
						<div class="col-md d-flex align-items-center justify-content-center py-5">
							{# Social #}
							<div class="h4 mb-3" class="mb-0 mr-2">{{ 'Seguinos' | translate }}</div>
							{% include "snipplets/social/social-footer.tpl" %}
						</div>
					</div>
				</div>
			</div>
		{% endif %}
	{% endif %}

	{{ component('nubesdk-slot', { type: "inside_footer" }) }}

	{# Footer legal and copyright #}
	<div class="footer-legal">
		<div class="container">
			<div class="row align-items-center">
				<div class="col-md text-center text-md-left font-small">
					<div class="mb-1 h6">
						{% if settings.footer_page_title and template != 'home' %}
							{% if template == 'page' %}
								<span class="crumb active">{{ page.name }}</span>
							{% elseif template == 'password' %}
								<span class="crumb active">{{ 'Página en construcción' | translate }}</span>
							{% elseif template == 'cart' %}
								<span class="crumb active">{{ "Carrito de compras" | translate }}</span>
							{% elseif template == 'search' %}
								<span class="crumb active">{{ "Resultados de búsqueda" | translate }}</span>
							{% elseif template == 'account.order' %}
								<span class="crumb active">{{ 'Orden {1}' | translate(order.number) }}</span>
							{% else %}
								{% for crumb in breadcrumbs %}
									{% if crumb.last %}
										<span class="crumb active">{{ crumb.name }}</span>
									{% endif %}
								{% endfor %}
							{% endif %}
							{% if template != '404' %}
							 -
							{% endif %}
						{% endif %}
						
						{{ store.name }}
					</div>
					<div class="d-block">
						&copy;{{ "now" | date('Y') }}. {{ (store.business_name ? store.business_name : store.name) }} {% if store.business_id %}- {{ store.business_id }}{% endif %}. {{ 'Todos los derechos reservados' | translate }}.
					</div>
	                {% if store.country == 'AR' %}
	                    <div class="claim-link d-block mt-md-1 mt-3">
	                       {{ "Defensa de las y los consumidores. Para reclamos" | translate }}
	                       <a class="font-weight-bold" href="https://www.argentina.gob.ar/produccion/defensadelconsumidor/formulario" target="_blank">{{ "ingrese aquí" | translate }}</a>
	                    </div>
	                {% endif %}

				</div>
				<div class="col-md-auto copyright row no-gutters text-center text-md-right align-items-center justify-content-center justify-content-md-end pt-4 pt-md-0">
					{#
					La leyenda que aparece debajo de esta linea de código debe mantenerse
					con las mismas palabras y con su apropiado link a Tienda Nube;
					como especifican nuestros términos de uso: http://www.tiendanube.com/terminos-de-uso .
					Si quieres puedes modificar el estilo y posición de la leyenda para que se adapte a
					tu sitio. Pero debe mantenerse visible para los visitantes y con el link funcional.
					Os créditos que aparece debaixo da linha de código deverá ser mantida com as mesmas
					palavras e com seu link para Nuvem Shop; como especificam nossos Termos de Uso:
					http://www.nuvemshop.com.br/termos-de-uso. Se você quiser poderá alterar o estilo
					e a posição dos créditos para que ele se adque ao seu site. Porém você precisa
					manter visivél e com um link funcionando.
					#}
					<div class="{% if "credits_logo.jpg" | has_custom_image %}col-auto{% else %}col-12{% endif %}">
						{{ new_powered_by_link }}
					</div>
					{% if "credits_logo.jpg" | has_custom_image %}
						<div class="credits-logo col-auto">
							{% if settings.credits_logo_url != '' %}
								<a href="{{ settings.credits_logo_url }}" target="_blank" title="{{ 'Créditos de la tienda' | translate }}">
							{% endif %}
								<img src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ "credits_logo.jpg" | static_url }}" class="partner-logo-img lazyload" alt="{{ 'Créditos de la tienda' | t }}"/>
							{% if settings.credits_logo_url != '' %}
								</a>
							{% endif %}
						</div>
					{% endif %}
				</div>
			</div>
		</div>
	</div>
	{% if settings.footer_background or settings.footer_background_mobile %}
		</div>
	{% endif %}
</footer>

{{ component('nubesdk-slot', { type: "after_footer" }) }}
