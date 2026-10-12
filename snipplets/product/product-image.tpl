{% if home_main_product %}
	{% set has_multiple_slides = product.media_count > 1 %}
{% else %}
	{% set has_multiple_slides = product.media_count > 1 or product.video_url %}
{% endif %}

{% set thumbs_mode = settings.product_gallery_color_variants_view %}
{% set show_all_thumbs = thumbs_mode == 'all' %}
{% set variationColors = product.variations|filter(v => v.name|lower in ['color','cor'])|first %}
{% set use_color_grouping = settings.product_gallery_color_variants and variationColors %}
{% set has_images_with_color = true %}
{% set zoom = settings.product_gallery_zoom %}
{% set nativeVideos = product.media|filter(m => m.isVideo) %}

{% if use_color_grouping %}
	{% set allImages = product.media|filter(m => m.isImage) %}
	{% set imagesWithoutColor = allImages %}
	{% set imagesGroupedByColors = {} %}
	{% set idsOfImagesWithoutColor = [] %}

	{% if allImages|length > 1 %}
		{% for color in variationColors.options %}
			{% set colorNameLowerCase = color.name|lower %}
			{% set colorImages = allImages|filter(image => colorNameLowerCase in (image.alt|lower)) %}
			{% if colorImages and colorImages|length > 0 %}
				{% set colorNameKey = colorNameLowerCase|lower|split(' ')|join %}
                {% set imagesGroupedByColors = imagesGroupedByColors|merge({ (colorNameKey): colorImages }) %}
                {% set imagesWithoutColor = imagesWithoutColor|filter(image => colorNameLowerCase not in (image.alt|lower)) %}
			{% endif %}
		{% endfor %}

        {% if imagesGroupedByColors and imagesGroupedByColors|length > 0 %}
            {% for color in variationColors.options %}
                {% set colorVariationKey = color.name|lower|split(' ')|join %}
                {% for key, images in imagesGroupedByColors %}
                    {% set tempKey = key|lower|split(' ')|join %}
                    {% if tempKey in colorVariationKey and (colorVariationKey|length) > (tempKey|length) %}
                        {% set imagesFiltered = images|filter(i => colorVariationKey not in (i.alt|lower|split(' ')|join)) %}
                        {% if imagesFiltered and imagesFiltered|length > 0 %}
                            {% set imagesGroupedByColors = imagesGroupedByColors|merge({(tempKey): imagesFiltered }) %}
                        {% endif %}
                    {% endif %}
                {% endfor %}
            {% endfor %}
        {% endif %}
	{% endif %}

	{% if imagesWithoutColor|length > 0 %}
		{% set imagesGroupedByColors = imagesGroupedByColors|merge({ 'Nocolor': imagesWithoutColor }) %}
		{% set idsOfImagesWithoutColor = imagesWithoutColor|map(i => i.id) %}
		{% set has_images_with_color = imagesGroupedByColors.Nocolor|length != allImages|length %}
	{% endif %}

	{% if variationColors %}
		{% set colorsWithoutImages = [] %}
		{% for color in variationColors.options %}
			{% set k = color.name|lower|split(' ')|join %}
			{% if attribute(imagesGroupedByColors, k) is not defined %}
				{% set colorsWithoutImages = colorsWithoutImages|merge([k]) %}
			{% endif %}
		{% endfor %}

		{% if show_all_thumbs %}
			{% set fallbackImages = allImages %}
		{% else %}
			{% if attribute(imagesGroupedByColors, 'Nocolor') is defined %}
				{% set fallbackImages = attribute(imagesGroupedByColors, 'Nocolor') %}
			{% else %}
				{% set fallbackImages = allImages %}
			{% endif %}
		{% endif %}

		{% if not show_all_thumbs and attribute(imagesGroupedByColors, 'Nocolor') is defined %}
			{% set imagesGroupedByColors = imagesGroupedByColors|map(images => (images|filter(image => image.id not in idsOfImagesWithoutColor))) %}
		{% endif %}

		{% for k in colorsWithoutImages %}
			{% set imagesGroupedByColors = imagesGroupedByColors|merge({ (k): fallbackImages }) %}
		{% endfor %}
	{% endif %}

	{% if show_all_thumbs and attribute(imagesGroupedByColors,'Nocolor') is defined %}
		{% set _nocolor = attribute(imagesGroupedByColors,'Nocolor') %}
		{% set _newGroups = {} %}
		{% for key, images in imagesGroupedByColors %}
			{% if key != 'Nocolor' %}
				{% set _colorIds = images|map(img => img.id) %}
				{% set _toAppend = _nocolor|filter(img => img.id not in _colorIds) %}
				{% set _combined = images|merge(_toAppend) %}
				{% set _newGroups = _newGroups|merge({ (key): _combined }) %}
			{% endif %}
		{% endfor %}
		{% if _newGroups|length > 0 %}
			{% set imagesGroupedByColors = _newGroups %}
		{% endif %}
	{% endif %}

	{% if imagesGroupedByColors|length == 0 %}
		{% set use_color_grouping = false %}
	{% endif %}

{% endif %}

{% if show_all_thumbs %}
	{% if imagesGroupedByColors|length > 0 %}
		{% set _keys = imagesGroupedByColors|keys %}
		{% set initialKey = _keys|first %}
	{% else %}
		{% set initialKey = 'Nocolor' %}
	{% endif %}
{% else %}
	{% set initialKey = 'Nocolor' %}
	{% if attribute(imagesGroupedByColors, 'Nocolor') is not defined and imagesGroupedByColors|length > 0 %}
		{% set _keys = imagesGroupedByColors|keys %}
		{% set initialKey = _keys|first %}
	{% endif %}
{% endif %}

{% if use_color_grouping %}
	{% set _initialImages = attribute(imagesGroupedByColors, initialKey) %}
{% endif %}

<div class="row" data-store="product-image-{{ product.id }}">
	{% include 'snipplets/product/product-banner.tpl' with { mobile: true } %}
	{% if has_multiple_slides %}
		<div class="{% if home_main_product or settings.product_gallery_layout == "next" %}d-none d-md-block{% else %} order-last order-md-0{% endif %} col-md-auto pr-md-0 mt-3 mt-md-0">
			<div class="product-thumbs-container position-relative">
				<div class="text-center d-none d-md-block product-thumbs-controls product-thumbs-prev">
					<div class="js-swiper-product-thumbs-prev swiper-button-prev swiper-product-thumb-control svg-icon-text">
						<svg class="icon-inline icon-lg icon-flip-vertical"><use xlink:href="#chevron-down"/></svg>
					</div>
				</div>

				<div class="js-swiper-product-thumbs swiper-container swiper-product-thumb {% if settings.product_gallery_layout == "next" %}d-none d-md-block{% endif %}">
					<div class="swiper-wrapper">
						{% if use_color_grouping and has_images_with_color %}
							{% for key, images in imagesGroupedByColors %}
								{% for image in images %}
									<div data-option="{{ key }}" data-product-id="{{ image.id }}" class="js-product-thumb-colors swiper-slide w-auto {% if key != initialKey %}d-none{% endif %}">
										{% include 'snipplets/product/product-image-thumbs.tpl' %}
									</div>
								{% endfor %}
							{% endfor %}
							{% for media in nativeVideos %}
								{% set native_video_index = _initialImages|length + loop.index0 %}
								<div class="swiper-slide w-auto">
									{% include 'snipplets/product/product-image-thumbs.tpl' with {thumb_index: native_video_index} %}
								</div>
							{% endfor %}
						{% else %}
							{% for media in product.media %}
								<div class="swiper-slide w-auto">
									{% include 'snipplets/product/product-image-thumbs.tpl' %}
								</div>
							{% endfor %}
						{% endif %}
						{% if not home_main_product and not settings.product_video_description and product.video_url %}
							<div class="swiper-slide w-auto">
								{% include 'snipplets/product/product-video.tpl' with {thumb: true} %}
							</div>
						{% endif %}
					</div>
				</div>
				<div class="text-center d-none d-md-block product-thumbs-controls product-thumbs-next">
					<div class="js-swiper-product-thumbs-next swiper-button-next swiper-product-thumb-control svg-icon-text">
						<svg class="icon-inline icon-lg"><use xlink:href="#chevron-down"/></svg>
					</div>
				</div>
			</div>
		</div>
	{% endif %}

	{% if product.media_count > 0 %}
		{% if use_color_grouping %}
			{% set _imagesAmount = _initialImages|length + nativeVideos|length %}
		{% else %}
			{% set _imagesAmount = product.media_count %}
		{% endif %}

		<div class="col-md {% if not has_multiple_slides %}product-with-one-image{% endif %} {% if home_main_product %}px-0 px-md-3{% else %}{% if settings.product_gallery_layout == "next" %}pr-0 pl-3{% else %}px-3{% endif %} mt-3{% endif %} mt-md-0">
			<div class="js-swiper-product swiper-container product-detail-slider" data-product-images-amount="{{ _imagesAmount }}">

				{{ component('nubesdk-slot', { type: "product_detail_image" }) }}

				{% include 'snipplets/labels.tpl' with {product_detail: true, labels_floating: true} %}

				<div class="swiper-wrapper">
					{% if use_color_grouping and has_images_with_color %}
						{% for key, images in imagesGroupedByColors %}
							{% for image in images %}
								<div data-option="{{ key }}" class="js-product-slide js-product-colors swiper-slide product-slide{% if home_main_product %}-small{% endif %} slider-slide {% if key != initialKey %}d-none{% endif %}" data-image="{{image.id}}" data-image-position="{{loop.index0}}">
									{% if home_main_product %}
										<div class="js-product-slide-link d-block position-relative" style="padding-bottom: {{ image.dimensions['height'] / image.dimensions['width'] * 100 }}%;">
									{% else %}
										<a {% if zoom == "modal"%}href="{{ image | product_image_url('4k') }}" data-fancybox="product-gallery-{{ key }}"{% endif %} class="js-product-slide-link d-block position-relative" style="padding-bottom: {{ image.dimensions['height'] / image.dimensions['width'] * 100 }}%;">
									{% endif %}
									
										{% set apply_lazy_load = home_main_product or not loop.first %}

										{% if apply_lazy_load %}
											{% set product_image_src = 'data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==' %}
										{% else %}
											{% set product_image_src = image | product_image_url('large') %}
										{% endif %}

										<img 
											{% if not apply_lazy_load %}fetchpriority="high"{% endif %}
											{% if apply_lazy_load %}data-{% endif %}src="{{ product_image_src }}"
											{% if apply_lazy_load %}data-{% endif %}srcset='{{  image | product_image_url('large') }} 480w, {{  image | product_image_url('huge') }} 640w, {{  image | product_image_url('original') }} 1024w, {{ image | product_image_url('1080p') }} 1920w, {{ image | product_image_url('1440p') }} 2560w, {{ image | product_image_url('4k') }} 3840w'
											class="js-product-slide-img product-slider-image img-absolute img-absolute-centered {% if apply_lazy_load %}lazyautosizes lazyload{% endif %}" 
											{% if apply_lazy_load %}data-sizes="auto"{% endif %}
											{% if image.dimensions.width and image.dimensions.height %}width="{{ image.dimensions.width }}" height="{{ image.dimensions.height }}"{% endif %}
											{% if zoom == "zoom" %}data-zoom="{{ image | product_image_url('4k') }}"{% endif %}
											alt="{{ image.alt ?: (product.name ~ ' - foto ' ~ loop.index) }}" />

									{% if home_main_product %}
										</div>
									{% else %}
										</a>
									{% endif %}
								</div>
							{% endfor %}
						{% endfor %}
						{% for media in nativeVideos %}
							{% set native_video_index = _initialImages|length + loop.index0 %}
							{% include 'snipplets/product/product-video.tpl' with {video_id: media.next_video, product_native_video: true, home_main_product: home_main_product, video_index: native_video_index} %}
						{% endfor %}
					{% else %}
						{% for media in product.media %}
							{% if media.isImage %}
								<div class="js-product-slide swiper-slide product-slide{% if home_main_product %}-small{% endif %} slider-slide" data-image="{{ media.id }}" data-image-position="{{ loop.index0 }}">
									{% if home_main_product %}
										<div class="js-product-slide-link d-block position-relative" style="padding-bottom: {{ media.dimensions['height'] / media.dimensions['width'] * 100 }}%;">
									{% else %}
										<a {% if zoom == "modal"%}href="{{ media | product_image_url('4k') }}" data-fancybox="product-gallery"{% endif %} class="js-product-slide-link d-block position-relative" style="padding-bottom: {{ media.dimensions['height'] / media.dimensions['width'] * 100 }}%;">
									{% endif %}
									
										{% set apply_lazy_load = home_main_product or not loop.first %}

										{% if apply_lazy_load %}
											{% set product_image_src = 'data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==' %}
										{% else %}
											{% set product_image_src = media | product_image_url('large') %}
										{% endif %}

										<img 
											{% if not apply_lazy_load %}fetchpriority="high"{% endif %}
											{% if apply_lazy_load %}data-{% endif %}src="{{ product_image_src }}"
											{% if apply_lazy_load %}data-{% endif %}srcset='{{  media | product_image_url('large') }} 480w, {{  media | product_image_url('huge') }} 640w, {{  media | product_image_url('original') }} 1024w, {{ media | product_image_url('1080p') }} 1920w, {{ media | product_image_url('1440p') }} 2560w, {{ media | product_image_url('4k') }} 3840w'
											class="js-product-slide-img product-slider-image img-absolute img-absolute-centered {% if apply_lazy_load %}lazyautosizes lazyload{% endif %}" 
											{% if apply_lazy_load %}data-sizes="auto"{% endif %}
											{% if media.dimensions.width and media.dimensions.height %}width="{{ media.dimensions.width }}" height="{{ media.dimensions.height }}"{% endif %}
											{% if zoom == "zoom" %}data-zoom="{{ media | product_image_url('4k') }}"{% endif %}
											alt="{{ media.alt ?: (product.name ~ ' - foto ' ~ loop.index) }}" />

									{% if home_main_product %}
										</div>
									{% else %}
										</a>
									{% endif %}
								</div>
							{% else %}
								{% include 'snipplets/product/product-video.tpl' with {video_id: media.next_video, product_native_video: true, home_main_product: home_main_product} %}
							{% endif %}
						{% endfor %}
					{% endif %}

					{% if not home_main_product and not settings.product_video_description %}
						{% include 'snipplets/product/product-video.tpl' %}
					{% endif %}
				</div>
			</div>
			{% if has_multiple_slides and home_main_product %}
				<div class="js-swiper-product-pagination swiper-pagination position-relative pt-3 pb-1 d-md-none"></div>
			{% endif %}
		</div>
	{% endif %}
</div>
