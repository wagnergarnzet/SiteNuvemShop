<section class="section-home section-grid-home" data-store="home-grid-banners">
    <div class="container">

        {% set banner_view_box = '0 0 1440 770' %}

        <div class="gridbanners" data-layout="4">

            {% for banner in 1..4 %}
                <div class="gridbanner banner-{{ loop.index }}">
                    <div class="gridbanner-image gridbanner-placeholder">
                        <svg viewBox='{{ banner_view_box }}' preserveAspectRatio="xMidYMid slice"><use xlink:href="#slider-slide-placeholder"/></svg>
                    </div>
                    <div class="gridbanner-text">
                        <div class="h2 mb-2 gridbanner-title gridbanner-title-with-btn">{{ "Banner" | translate }} {{ loop.index }}</div>
                    </div>
                </div>
            {% endfor %}
            <div class="placeholder-overlay transition-soft">
                <div class="placeholder-info">
                    <svg class="icon-inline icon-3x"><use xlink:href="#edit"/></svg>
                    <div class="placeholder-description font-small-xs">
                        {{ "Podés subir tus imágenes desde" | translate }} <strong>"{{ "Banners en grilla" | translate }}"</strong>
                    </div>
                    {% if not params.preview %}
                        <a href="{{ admin_link }}#instatheme=pagina-de-inicio" class="btn-primary btn btn-small placeholder-button">{{ "Editar" | translate }}</a>
                    {% endif %}
                </div>
            </div>
        </div>
    </div>
</section>