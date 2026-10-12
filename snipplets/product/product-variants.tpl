{% set bullet_variants = settings.bullet_variants %}
{% set variants_card = variants_card | default(false) %}

<div class="js-product-variants form-row {% if quickshop %}js-product-quickshop-variants{% endif %}">
	{% set has_size_variations = false %}
	{% for variation in product.variations %}
	
		{% set variation_color = false %}
		{% set variation_size = false %}

		{% if variation.name|lower in ['color', 'cor'] %}
			{% set variation_color = true %}
		{% endif %}
		{% if variation.name|lower in ['talle', 'talla', 'tamanho', 'size'] %}
			{% set variation_size = true %}
		{% endif %}

		{% if variation.name|lower in ['quantidade','cantidad','quantity'] %}
			{% set variation_quantity = true %}
		{% endif %}

		{% if bullet_variants %}
			{% set hidden_variant_select = ' d-none' %}
		{% elseif settings.image_color_variants and variation_color %}
			{% set hidden_variant_select = ' d-none' %}
		{% else %}
			{% set hidden_variant_select = ' d-block' %}
		{% endif %}

		{% set is_button_variant = settings.bullet_variants or (settings.image_color_variants and variation_color) %}

		<div class="js-product-variants-group js-variant-container variant-container {% if variation_color %}js-color-variants-container{% endif %} {% if variation_quantity %}js-product-quantity{% endif %} {% if settings.bullet_variants or settings.image_color_variants %}col-12 {% if is_hidden_select or settings.bullet_variants %}mb-2{% endif %}{% endif %} {% if is_button_variant and show_size_guide and settings.size_guide_url and has_size_variations and loop.last %}mb-0{% endif %} {% if not is_button_variant %}{% if loop.length == 1 or loop.length == 3 or settings.image_color_variants %}col-md-8{% else %}col-6{% endif %}{% endif %}" data-variation-id="{{ variation.id }}">
			{% if quickshop %}
				{% embed "snipplets/forms/form-select.tpl" with{select_label: true, select_label_name: '' ~ variation.name ~ '', select_for: 'variation_' ~ loop.index , select_id: 'variation_' ~ loop.index, select_name: 'variation' ~ '[' ~ variation.id ~ ']', select_custom_class: 'js-variation-option js-refresh-installment-data form-control-small', select_label_custom_class:'mb-1', select_md: true, select_group_custom_class: hidden_variant_select} %}
					{% block select_options %}
						{% for option in variation.options %}
							<option value="{{ option.id }}" {% if product.default_options[variation.id] is same as(option.id) %}selected="selected"{% endif %}>{{ option.name }}</option>
						{% endfor %}
					{% endblock select_options %}
				{% endembed %}
			{% else %}
				{% embed "snipplets/forms/form-select.tpl" with{select_label: true, select_label_name: '' ~ variation.name ~ '', select_for: 'variation_' ~ loop.index , select_id: 'variation_' ~ loop.index, select_name: 'variation' ~ '[' ~ variation.id ~ ']', select_custom_class: 'js-variation-option js-refresh-installment-data', select_group_custom_class: hidden_variant_select} %}
					{% block select_options %}
						{% for option in variation.options %}
							<option value="{{ option.id }}" {% if product.default_options[variation.id] is same as(option.id) %}selected="selected"{% endif %}>{{ option.name }}</option>
						{% endfor %}
					{% endblock select_options %}
				{% endembed %}
			{% endif %}
			{% if is_button_variant %}
				<label class="form-label">{{ variation.name }}: <strong class="js-insta-variation-label">{{ product.default_options[variation.id] }}</strong></label>
				<div class="row no-gutters align-items-center justify-content-start no-scrollbar">
				{% for option in variation.options %}
					<a data-option="{{ option.id }}" class="js-insta-variant btn-variant{% if product.default_options[variation.id] is same as(option.id) %} selected{% endif %} {% if variation_color %}variant-color{% else %}bullet-variation{% endif %} insta-variations" title="{{ option.name }}" data-option="{{ option.id }}" data-variation-id="{{ variation.id }}">
						<span class="btn-variant-content{% if settings.image_color_variants and variation_color %} btn-variant-content-square{% endif %}"{% if option.custom_data and variation_color and (bullet_variants and not settings.image_color_variants) %} style="background: {{ option.custom_data }}; border: 2px solid #eee"{% endif %} data-name="{{ option.name }}">
							{% if settings.image_color_variants and variation_color %}
								{% if product.default_options[variation.id] is same as(option.id) %}
									<img src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ product.featured_variant_image | product_image_url('thumb')}}" data-sizes="auto" class="lazyload img-absolute-centered-vertically" {% if image.alt %}alt="{{image.alt}}"{% endif %} />
								{% else %}
									{% for variant in product.variants if (variant.option1 == option.id) or (variant.option2 == option.id) or (variant.option3 == option.id) %}
										{% if loop.first %}
											<img src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ variant.image | product_image_url('thumb') }}" data-sizes="auto" class="lazyload img-absolute-centered-vertically" />
										{% endif %}
									{% endfor %}
								{% endif %}
							{% endif %}
							{% if not(variation_color) or (variation_color and not option.custom_data and not settings.image_color_variants) %}
								{{ option.name }}
							{% endif %}
						</span>
					</a>
				{% endfor %}
				</div>
			{% endif %}
		</div>

		{% if variation_size %}
			{% set has_size_variations = true %}
		{% endif %}

	{% endfor %}
	{% if show_size_guide and settings.size_guide_url and has_size_variations %}
		{% set has_size_guide_page_finded = false %}
		{% set size_guide_url_handle = settings.size_guide_url | trim('/') | split('/') | last %}

		{% for page in pages if page.handle == size_guide_url_handle and not has_size_guide_page_finded %}
			{% set has_size_guide_page_finded = true %}
			{% if has_size_guide_page_finded %}
				<div class="col">
					<a data-toggle="#size-guide-modal" data-modal-url="modal-fullscreen-size-guide" class="js-modal-open js-fullscreen-modal-open btn btn-link btn-line btn-small mb-2">
						<svg class="icon-inline icon-lg svg-icon-primary mr-1"><use xlink:href="#arrows-h"/></svg>
						{{ 'Guía de talles' | translate }}
					</a>
					{% embed "snipplets/modal.tpl" with{modal_id: 'size-guide-modal', modal_position: 'bottom', modal_transition: 'slide', modal_header: true, modal_width: 'centered-md modal-centered-medium', modal_mobile_full_screen: 'true'} %}
						{% block modal_head %}
							{{ 'Guía de talles' | translate }}
						{% endblock %}
						{% block modal_body %}
							<div class="user-content py-2 px-3">
								{{ page.content }}
							</div>
						{% endblock %}
					{% endembed %}
				</div>
			{% endif %}
		{% endfor %}
	{% endif %}
</div>