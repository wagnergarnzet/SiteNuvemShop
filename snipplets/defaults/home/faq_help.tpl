<section class="section-home section-faq position-relative" data-store="home-faq" data-transition="fade-in-up">
    <div class="container">
        <div class="section-title {% if settings.section_title_uppercase %}section-title-uppercase{% endif %} mx-auto row">
            <div class="col-12 text-center">
                <h2 class="text-heading mb-0">{{ "Preguntas frecuentes" | translate }}</h2>
            </div>
            <div class="col-12 text-center mt-2">
                <p class="home-subtitle text-subtitle mb-0">{{ "Usá este espacio para resolver las dudas más comunes de tus clientes" | translate }}</p>
            </div>
        </div>
        <div class="faq-list mx-auto">
            {% for item in 1..3 %}
                <div class="faq-item">
                    <div class="faq-question">
                        <span class="faq-question-text">{{ "Pregunta" | translate }} {{ item }}</span>
                        <span class="faq-question-icon">
                            <svg class="icon-inline icon-md"><use xlink:href="#plus"/></svg>
                        </span>
                    </div>
                    <div class="faq-answer">
                        <div class="faq-answer-inner">
                            {{ "Acá podés escribir la respuesta rápida para tus clientes." | translate }}
                        </div>
                    </div>
                </div>
            {% endfor %}
        </div>
    </div>
    {% if not params.preview %}
        <div class="placeholder-overlay transition-soft">
            <div class="placeholder-info">
                <svg class="icon-inline icon-3x"><use xlink:href="#edit"/></svg>
                <div class="placeholder-description font-small-xs">
                    {{ "Podés gestionar tus preguntas frecuentes desde" | translate }} <strong>"{{ "Preguntas frecuentes" | translate }}"</strong>
                </div>
                <a href="{{ admin_link }}#instatheme=pagina-de-inicio" class="btn-primary btn btn-small placeholder-button">{{ "Editar" | translate }}</a>
            </div>
        </div>
    {% endif %}
</section>
