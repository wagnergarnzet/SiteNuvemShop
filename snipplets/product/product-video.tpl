{% if product.video_url or product_native_video %}
	{% if video_index is not defined %}
		{% if product.media_count > 1 %}
			{% set video_index = product.media_count %}
		{% else %}
			{% set video_index = 1 %}
		{% endif %}
		{% if product_native_video %}
			{% set video_index = loop.index0 %}
		{% endif %}
	{% endif %}

	{% if thumb %}
		<a href="#" class="js-product-thumb js-video-thumb {% if product_native_video %}js-product-native-video-thumb {% endif %}product-thumb d-block mb-3" data-thumb-loop="{{ video_index }}" {% if product_native_video %}data-video_id="{{ media.id }}"{% endif %}>
			{% include 'snipplets/video-item.tpl' with {thumb: true, product_native_video: product_native_video} %}
		</a>
	{% elseif video_description %}
		<div class="product-video col-12 mt-3">
			{# Visible video inside slider #}
			{% include 'snipplets/video-item.tpl' with {product_modal_trigger: true, product_video: true, product_native_video: product_native_video, video_id: video_id, home_main_product: home_main_product} %}

			{# Hidden video inside modal #}
			{% include 'snipplets/video-item.tpl' with {product_modal: true, product_video: true, product_native_video: product_native_video, video_id: video_id, home_main_product: home_main_product} %}
		</div>
	{% else %}
		<div class="js-product-slide js-product-video-slide swiper-slide slider-slide {% if product_native_video %}product-native-video-slide js-product-native-video-slide{% endif %} {% if home_main_product %}w-100{% endif %}" data-image-position="{{ video_index }}">
			<div class="product-video-container">
				<div class="product-video">

					{# Visible video inside slider #}
					{% include 'snipplets/video-item.tpl' with {product_modal_trigger: true, product_video: true, product_native_video: product_native_video, video_id: video_id, home_main_product: home_main_product} %}

					{# Hidden video inside modal #}
					{% include 'snipplets/video-item.tpl' with {product_modal: true, product_video: true, product_native_video: product_native_video, video_id: video_id, home_main_product: home_main_product} %}
				</div>
			</div>
		</div>
	{% endif %}
{% endif %}
