<div class="mb-5">
    {% embed "snipplets/page-header.tpl" with { breadcrumbs: true } %}
        {% block page_header_text %}{{ "Blog" | translate }}{% endblock page_header_text %}
    {% endembed %}
    <section class="blog-page container">
        <div class="row">
            {% for post in blog.posts %}
                <div class="col-md-4 mb-4">
                    {{ component(
                        'blog/blog-post-item', {
                            image_lazy: true,
                            image_lazy_js: true,
                            post_item_classes: {
                                item: 'item',
                                image_container: '',
                                image: 'img-absolute img-absolute-centered fade-in',
                                information: 'item-description pt-3',
                                title: 'item-name mb-2 text-center text-md-left',
                                summary: 'mb-3 font-small',
                                read_more: 'btn-link btn-link-primary text-center text-md-left',
                            },
                        })
                    }}
                </div>
            {% endfor %}
        </div>
        {% include 'snipplets/grid/pagination.tpl' with {'pages': blog.pages} %}
    </section>
</div>
