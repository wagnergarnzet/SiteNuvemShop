<section class="section-home section-home-extra-menu" data-store="home-extra-menu">
    <div class="container">
        <div class="row">
            <div class="extra-menu col-12 d-flex align-items-center justify-content-center text-center">
                {% for i in 1..5 %}
                    <a href="#"><span>{{ "Página" | translate }} {{ loop.index }}</span></a>
                {% endfor %}
            </div>
        </div>
    </div>
</section>