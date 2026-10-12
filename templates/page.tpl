{% set custom_page_link = settings.custom_page_link | trim('/') | split('/') | last %}
{% set page_url = page.url | trim('/') | split('/') | last %}
{% set faq_page_link = settings.faq_page_link | trim('/') | split('/') | last %}
{% set faq_page_display = settings.faq_page_display %}
{% set is_faq_page = settings.faq_page_show and faq_page_link == page_url %}

{% if settings.custom_page_show and custom_page_link == page_url %}

	{% include 'snipplets/page-custom.tpl' %}

{% else %}

		{% embed "snipplets/page-header.tpl" with {'breadcrumbs': true} %}
			{% block page_header_text %}{{ page.name }}{% endblock page_header_text %}
		{% endembed %}

		{# Institutional page  #}

		<section class="user-content">
			<div class="container">
				{% if is_faq_page and faq_page_display == 'page' %}
					{% include 'snipplets/home/home-faq.tpl' with {'faq_page': true} %}
				{% else %}
					<div class="row">
						<div class="col-md-12">
							{{ page.content }}
						</div>
					</div>
				{% endif %}
			</div>
		</section>

		{% if is_faq_page and faq_page_display == 'below' %}
			{% include 'snipplets/home/home-faq.tpl' %}
		{% endif %}

		{% if settings.institutional_on_pages %}
			{% include 'snipplets/home/home-institutional.tpl' with {textoverimage: true} %}
		{% endif %}

{% endif %}
