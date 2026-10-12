{% set subutilities = subutilities | default(false) %}
{% set has_social_network = store.facebook or store.twitter or store.pinterest or store.instagram %}
{% set show_top_bar = settings.top_bar and (store.phone or store.email and has_social_network) %}
{% set show_utilities_languages = show_utilities_languages | default((languages | length > 1) and not show_top_bar) %}

{% if subutilities %}
<div class="utilities-container d-flex align-items-stretch justify-content-end">
	<div class="row">
		<div class="col d-inline-flex text-right align-items-right justify-content-center">
			{% if settings.head_style == "style3" or settings.head_style == "style4" %}
			<div class="utilities-item p-0 d-none d-md-inline-block py-2">
				<div class="head-search-icon">
					<a href="#" class="js-modal-open js-toggle-search js-fullscreen-modal-open js-search-link" data-toggle="#nav-search" data-modal-url="modal-fullscreen-search">
						<svg class="icon-inline"><use xlink:href="#search"/></svg>
					</a>
				</div>
			</div>
			{% endif %}
			{% if show_utilities_languages %}
				<div class="utilities-item d-none d-lg-flex align-items-center mr-2">
					{% include "snipplets/languages.tpl" %}
				</div>
			{% endif %}
			<div class="utilities-item pl-2 d-none d-md-inline-block transition-soft">
				<div class="js-utilities-item nav-account position-relative py-2">
					<div class="utility-head text-center">
						{% if "icon_account.png" | has_custom_image %}
							<img src="{{ "icon_account.png" | static_url | settings_image_url('thumb') }}" class="icon-inline mr-2" alt="{{ "Mi cuenta" | translate }}">
						{% else %}
							<svg class="icon-inline mr-2"><use xlink:href="#user"/></svg>
						{% endif %}
						{% if store.country == 'AR'%}
							{# Notification tooltip for quick login on AR stores #}
							<a data-toggle="#quick-login" class="js-modal-open js-quick-login-badge" style="display: none;">
								<div class="badge badge-overlap swing"></div>
							</a>
						{% endif %}
					</div>
					<ul class="js-subutility-list subutility-list" data-store="account-links">	
						{% if not customer %}
							{% if 'mandatory' not in store.customer_accounts %}
								<li class="subutility-list-item">{{ "Crear cuenta" | translate | a_tag(store.customer_register_url, '', 'nav-accounts-link') }}</li>
							{% endif %}
								<li class="subutility-list-item">{{ "Iniciar sesión" | translate | a_tag(store.customer_login_url, '', 'js-login nav-accounts-link') }}</li>
							{% else %}
							<li class="subutility-list-item">{{ "Mi cuenta" | translate | a_tag(store.customer_home_url, '', 'nav-accounts-link') }}</li>
							<li class="subutility-list-item">{{ "Cerrar sesión" | translate | a_tag(store.customer_logout_url, '', 'nav-accounts-link') }}</li>
						{% endif %}
					</ul>
				</div>
			</div>
			{% if not store.is_catalog %}
			<div class="utilities-item text-right">
				<div id="ajax-cart" class="js-cart-summary nav-dropdown cart-summary" data-component='cart-button'>
					<a href="{% if settings.ajax_cart %}#{% else %}{{ store.cart_url }}{% endif %}" class="d-inline-block py-2 {% if template != 'cart' and settings.ajax_cart %}js-modal-open js-toggle-cart js-fullscreen-modal-open{% endif %} {% if cart.items_count > 0 %}link-cart active{% endif %} js-cart-link" {% if settings.ajax_cart %}data-toggle="#modal-cart" data-modal-url="modal-fullscreen-cart"{% endif %}>
						{% include "snipplets/icon-cart.tpl" with {custom_cart_icon: true, icon_custom_class: "icon-inline icon-1x"} %}
						<span class="js-cart-widget-amount badge cart-widget-amount d-flex align-items-center justify-content-center">{{ "{1}" | translate(cart.items_count ) }}</span>
					</a>
				</div>
			</div>
			{% endif %}
		</div>
	</div>
</div>
{% else %}
<div class="utilities-container d-flex align-items-stretch justify-content-end">
	{% if settings.head_style == "style3" or settings.head_style == "style4" %}
	<div class="utilities-item d-none d-md-flex align-items-center py-2">
		<div class="head-search-icon">
			<a href="#" class="js-modal-open js-toggle-search js-fullscreen-modal-open js-search-link pr-2" data-toggle="#nav-search" data-modal-url="modal-fullscreen-search">
				<svg class="icon-inline"><use xlink:href="#search"/></svg>
			</a>
		</div>
	</div>
	{% endif %}
	{% if show_utilities_languages %}
	<div class="utilities-item d-none d-lg-flex align-items-center mr-2">
		{% include "snipplets/languages.tpl" %}
	</div>
	{% endif %}
	<div class="utilities-item d-none d-lg-flex align-items-center" data-store="account-links">
		{% if settings.head_style == "style1" or settings.head_style == "style2" %}
			{% if "icon_account.png" | has_custom_image %}
				<img src="{{ "icon_account.png" | static_url | settings_image_url('thumb') }}" class="icon-inline mr-2" alt="{{ "Mi cuenta" | translate }}">
			{% else %}
				<svg class="icon-inline mr-2"><use xlink:href="#user"/></svg>
			{% endif %}
			{% if not customer %}
				{% if 'mandatory' not in store.customer_accounts %}
				<span class="nav-accounts-item pr-1">{{ "Crear cuenta" | translate | a_tag(store.customer_register_url, '', 'nav-accounts-link') }}</span><span class="mx-1">|</span>
				{% endif %}
				<span class="nav-accounts-item pl-1 pr-4">{{ "Iniciar sesión" | translate | a_tag(store.customer_login_url, '', 'nav-accounts-link') }}</span>
			{% else %}
				<span class="nav-accounts-item pr-2">{{ "Mi cuenta" | translate | a_tag(store.customer_home_url, '', 'nav-accounts-link') }}</span>
				<span class="nav-accounts-item pr-4">
					<svg class="icon-inline mr-2"><use xlink:href="#times-circle"/></svg>
					{{ "Cerrar sesión" | translate | a_tag(store.customer_logout_url, '', 'nav-accounts-link') }}
				</span>
			{% endif %}
		{% else %}
			{% if "icon_account.png" | has_custom_image %}
				<img src="{{ "icon_account.png" | static_url | settings_image_url('thumb') }}" class="icon-inline mr-2" alt="{{ "Mi cuenta" | translate }}">
			{% else %}
				<svg class="icon-inline mr-2"><use xlink:href="#user"/></svg>
			{% endif %}
		{% endif %}
	</div>
	{% if not store.is_catalog %}
	<div class="utilities-item d-flex align-items-center">
		<div id="ajax-cart" class="js-cart-summary nav-dropdown cart-summary" data-component='cart-button'>
			<a href="{% if settings.ajax_cart %}#{% else %}{{ store.cart_url }}{% endif %}" class="d-inline-block py-2 {% if template != 'cart' and settings.ajax_cart %}js-modal-open js-toggle-cart js-fullscreen-modal-open{% endif %} {% if cart.items_count > 0 %}link-cart active{% endif %} js-cart-link" {% if settings.ajax_cart %}data-toggle="#modal-cart" data-modal-url="modal-fullscreen-cart"{% endif %}>
				{% include "snipplets/icon-cart.tpl" with {custom_cart_icon: true, icon_custom_class: "icon-inline icon-1x"} %}
				<span class="js-cart-widget-amount badge cart-widget-amount d-flex align-items-center justify-content-center">{{ "{1}" | translate(cart.items_count ) }}</span>
			</a>
		</div>
	</div>
	{% endif %}
</div>
{% endif %}
