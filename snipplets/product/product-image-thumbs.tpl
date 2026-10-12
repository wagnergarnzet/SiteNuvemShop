{% set thumb_media = media is defined ? media : image %}
{% set thumb_is_video = media is defined and media.isVideo %}
{% set thumb_loop = thumb_index | default(loop.index0) %}
{% set thumb_padding = thumb_is_video ? 56.25 : thumb_media.dimensions['height'] / thumb_media.dimensions['width'] * 100 %}

<a href="#" {% if thumb_is_video %}data-video_id="{{ thumb_media.id }}"{% endif %} class="js-product-thumb {% if loop.last and last_open_modal %}js-product-thumb-modal{% endif %} {% if thumb_is_video %}js-video-thumb js-product-native-video-thumb{% endif %} product-thumb d-block position-relative mr-3 mr-md-0 mb-md-3 {% if loop.first %}selected{% endif %}" style="padding-bottom: {{ thumb_padding }}%;" data-thumb-loop="{{ thumb_loop }}">
    {% if thumb_is_video %}
        <div class="video-player-icon video-player-icon-small">
            <svg class="icon-inline icon-2x svg-icon-text"><use xlink:href="#play"/></svg>
        </div>
        <img data-sizes="auto" src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ thumb_media.thumbnail }}" class="img-absolute img-absolute-centered lazyautosizes lazyload" alt="{{ 'Video de' | translate }} {% if template != 'product' %}{{ product.name }}{% else %}{{ store.name }}{% endif %}" />
    {% else %}
        <img data-sizes="auto" src="{{ 'images/empty-placeholder.png' | static_url }}" data-srcset='{{  thumb_media | product_image_url('large') }} 480w, {{  thumb_media | product_image_url('huge') }} 640w' class="img-absolute img-absolute-centered lazyautosizes lazyload" {% if thumb_media.alt %}alt="{{thumb_media.alt}}"{% endif %} />
    {% endif %}
</a>
