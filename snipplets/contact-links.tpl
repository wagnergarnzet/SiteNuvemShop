{# /*============================================================================
  #Contact links
==============================================================================*/#}

<ul class="contact-info">
{% if contact_page %}
	<div class="h4 mb-4">{{ settings.footer_contact_title }}</div>
{% endif %}
{% if store.whatsapp %}
	<li class="contact-item {% if contact_page %}d-flex{% endif %}">
		{% if contact_page %}
			<div class="d-inline-block">
				<svg class="icon-inline icon-1x icon-w-14 mr-2"><use xlink:href="#whatsapp"/></svg>
			</div>
		{% else %}
			<svg class="icon-inline icon-1x icon-w-14 mr-1"><use xlink:href="#whatsapp"/></svg>
		{% endif %}
		{% if contact_page %}
			<div class="d-inline-block">
		{% endif %}
			{% if titles %}
				<span class="d-block mb-1 font-weight-bold">{{ "WhatsApp" | translate }}</span>
			{% endif %}
			<a href="{{ store.whatsapp }}{% if settings.wpp_message %}?text={{ settings.wpp_message }}{% endif %}" target="_blank" class="contact-link contact-whatsapp">{{ store.whatsapp | trim('/') | split('/') | last }}</a>
		{% if contact_page %}
			</div>
		{% endif %}
	</li>
{% endif %}
{% if store.phone %}
	<li class="contact-item {% if contact_page %}d-flex{% endif %}">
		{% if contact_page %}
			<div class="d-inline-block">
				<svg class="icon-inline icon-1x icon-w-14 mr-2"><use xlink:href="#earphone"/></svg>
			</div>
		{% else %}
			<svg class="icon-inline icon-1x icon-w-14 mr-1"><use xlink:href="#earphone"/></svg>
		{% endif %}
		{% if contact_page %}
			<div class="d-inline-block">
		{% endif %}
			{% if titles %}
				<span class="d-block mb-1 font-weight-bold">{{ "Teléfono" | translate }}</span>
			{% endif %}
			<a href="tel:{{ store.phone }}" class="contact-link">{{ store.phone }}</a>
		{% if contact_page %}
			</div>
		{% endif %}
	</li>
{% endif %}
{% if store.email %}
	<li class="contact-item {% if contact_page %}d-flex{% endif %}">
		{% if contact_page %}
			<div class="d-inline-block">
				<svg class="icon-inline icon-1x icon-w-14 mr-2"><use xlink:href="#icon-email"/></svg>
			</div>
		{% else %}
			<svg class="icon-inline icon-1x icon-w-14 mr-1"><use xlink:href="#icon-email"/></svg>
		{% endif %}
		{% if contact_page %}
			<div class="d-inline-block">
		{% endif %}
			{% if titles %}
				<span class="d-block mb-1 font-weight-bold">{{ "Email" | translate }}</span>
			{% endif %}
			<a href="mailto:{{ store.email }}" class="contact-link">{{ store.email }}</a>
		{% if contact_page %}
			</div>
		{% endif %}
	</li>
{% endif %}
{% if not phone_and_mail_only %}
	{% if store.address %}
		<li class="contact-item {% if contact_page %}d-flex{% endif %}">
			{% if contact_page %}
				<div class="d-inline-block">
					<svg class="icon-inline icon-1x icon-w-14 mr-2"><use xlink:href="#icon-store"/></svg>
				</div>
			{% else %}
				<svg class="icon-inline icon-1x icon-w-14 mr-1"><use xlink:href="#icon-store"/></svg>
			{% endif %}
			{% if contact_page %}
				<div class="d-inline-block">
			{% endif %}
				{% if titles %}
					<span class="d-block mb-1 font-weight-bold">{{ "Dirección" | translate }}</span>
				{% endif %}
				{{ store.address }}
			{% if contact_page %}
				</div>
			{% endif %}
		</li>
	{% endif %}
	{% if settings.store_hours %}
		<li class="contact-item {% if contact_page %}d-flex{% endif %}">
			{% if contact_page %}
				<div class="d-inline-block">
					<svg class="icon-inline icon-1x icon-w-14 mr-2"><use xlink:href="#time"/></svg>
				</div>
			{% else %}
				<svg class="icon-inline icon-1x icon-w-14 mr-1"><use xlink:href="#time"/></svg>
			{% endif %}
			{% if contact_page %}
				<div class="d-inline-block">
			{% endif %}
				{% if titles %}
					<span class="d-block mb-1 font-weight-bold">{{ "Horarios de atención" | translate }}</span>
				{% endif %}
				{{ settings.store_hours }}
			{% if contact_page %}
				</div>
			{% endif %}
		</li>
	{% endif %}
	{% if store.blog %}
		<li class="contact-item {% if contact_page %}d-flex{% endif %}">
			{% if contact_page %}
				<div class="d-inline-block">
					<svg class="icon-inline icon-1x icon-w-14 mr-2"><use xlink:href="#comments"/></svg>
				</div>
			{% else %}
				<svg class="icon-inline icon-1x icon-w-14 mr-1"><use xlink:href="#comments"/></svg>
			{% endif %}
			{% if contact_page %}
				<div class="d-inline-block">
			{% endif %}
				{% if titles %}
					<span class="d-block mb-1 font-weight-bold">{{ "Blog" | translate }}</span>
				{% endif %}
				<a target="_blank" href="{{ store.blog }}" class="contact-link">{{ "Visita nuestro Blog!" | translate }}</a>
			{% if contact_page %}
				</div>
			{% endif %}
		</li>
	{% endif %}
{% endif %}
</ul>