{#/*============================================================================
style.scss.tpl

    -This file contains all the theme styles related to settings defined by user from config/settings.txt
    -Rest of styling can be found in:
      --static/css/style-async.css.tpl --> For non critical styles witch will be loaded asynchronously
      --static/css/style-critical.tpl --> For critical CSS rendered inline before the rest of the site

==============================================================================*/#}

{# /*============================================================================
  Table of Contents

  #Colors and fonts
    // Functions
    // Colors
    // Font families
    // SVG Icons
    // Texts
  #Components
    // Margin and padding
    // Mixins
    // Animations
    // Wrappers
    // Placeholders
    // Dividers
    // Breadcrumbs
    // Headings
    // Buttons
    // Links
    // Modals
    // Forms
    // Tabs
    // Cards
    // Panels
    // Pills
    // Preloaders
    // Banners
    // Sliders
    // Tables
    // Shadows
    // Scrollbars
  #Home page
    // Instafeed
    // Video
  #Product grid
    // Grid item
    // Labels
    // Filters
  #Product detail
    // Image
    // Form and info
  #Cart
    // Cart Summary
    // Cart Ajax
  #Contact page
    // Data contact
  #Account page
    // Order items
  #Header and nav
    // Ad Bar
    // Header
    // Search
  #Footer
  #Media queries
    // Forms

==============================================================================*/ #}

{#/*============================================================================
  #Colors and fonts
==============================================================================*/#}

{# /* // Colors */ #}

{% if settings.background_color %}
  $background-color: {{ settings.background_color|raw }};
{% else %}
  $background-color: #fff;
{% endif %}

{% if settings.text_color %}
  $text-color: {{ settings.text_color|raw }};
{% else %}
  $text-color: #111;
{% endif %}

{% if settings.primary_color %}
  $primary-color: {{ settings.primary_color|raw }};
{% else %}
  $primary-color: {{ settings.text_color|raw }};
{% endif %}
{% if settings.secondary_color %}
  $secondary-color: {{ settings.secondary_color|raw }};
{% else %}
  $secondary-color: {{ settings.text_color|raw }};
{% endif %}

{% if settings.accent_color %}
  $accent-color: {{ settings.accent_color|raw }};
{% else %}
  $accent-color: {{ settings.text_color|raw }};
{% endif %}

{# /* // Functions */ #}

@function brightness($color) {
  $sum: red($color) + green($color) + blue($color);
  @return percentage($sum / (255*3));
}

@function set-foreground-color($bg-color, $foreground-color) {
  @if (lightness($bg-color) > 50) {
    @return $foreground-color; // Lighter background, return dark color
  } @else {
    @return lighten($foreground-color, 15%); // Darker background, return light color
  }
}

@function set-foreground-color-invert($bg-color, $foreground-color) {
  @if (lightness($bg-color) > 50) {
    @return darken($foreground-color, 100%); // black foreground over white background
  } @else {
    @return lighten($foreground-color, 15%); // no dark foreground on dark background
  }
}

@function set-foreground-color-footer($bg-color, $foreground-color) {
  @if (lightness($bg-color) > 50) {
    @return $foreground-color; // Lighter backgorund, return dark color
  } @else {
    @return lighten($foreground-color, 30%); // Darker background, return light color
  }
}

@function set-subnav-color($nav-color) {
  @if (lightness($nav-color) > 25) {
    @return rgba(0,0,0,0.05); // Lighter backgorund, return dark color
  } @else {
    @return rgba(255,255,255,0.05); // Darker background, return light color
  }
}

@function dark-color() {
  {% if not settings.primary_color %}
    $primary-color: #D61D40;
  {% else %}
    $primary-color: {{ settings.primary_color }};
  {% endif %}
  $secondary-color: {{ settings.secondary_color }};

  @if (brightness($secondary-color) > 66) {
    @return $primary-color; // Lighter background, return dark color
  } @else {
    @return $secondary-color; // Darker background, return light color
  }
}

@function darker-color() {
  {% if not settings.primary_color %}
    $primary-color: #D61D40;
  {% else %}
    $primary-color: {{ settings.primary_color }};
  {% endif %}
  $secondary-color: {{ settings.secondary_color }};

  @if (brightness($secondary-color) > brightness($primary-color)) {
    @return $primary-color;
  } @else {
    @return $secondary-color;
  }
}

@function lighter-color() {
  {% if not settings.primary_color %}
    $primary-color: #D61D40;
  {% else %}
    $primary-color: {{ settings.primary_color }};
  {% endif %}
  $secondary-color: {{ settings.secondary_color }};

  @if (brightness($secondary-color) > brightness($primary-color)) {
    @return $secondary-color;
  } @else {
    @return $primary-color;
  }
}

@function text-on-primary() {
  {% if not settings.primary_color %}
    $primary-color: #D61D40;
  {% else %}
    $primary-color: {{ settings.primary_color }};
  {% endif %}
  $secondary-color: {{ settings.secondary_color }};

  @if (brightness($primary-color) > 66) {
    @return $secondary-color; // Lighter background, return dark color
  } @else {
    @return $background-color; // Darker background, return light color
  }
}

@function dark-brand-color() {
  {% if not settings.primary_color %}
    $primary-color: #D61D40;
  {% else %}
    $primary-color: {{ settings.primary_color }};
  {% endif %}
  $text-color: {{ settings.text_color }};

  @if (brightness($primary-color) < 66) {
    @return $primary-color;
  } @else {
    @return $text-color;
  }
}

@function light-color() {
  {% if not settings.primary_color %}
    $primary-color: #D61D40;
  {% else %}
    $primary-color: {{ settings.primary_color }};
  {% endif %}
  $background-color: {{ settings.background_color }};
  $secondary-color: {{ settings.secondary_color }};

  @if (brightness($primary-color) > 66) {
    @return $primary-color; // Lighter background, return dark color
  } @else if (brightness($secondary-color) > 66) {
    @return $secondary-color;
  } @else {
    @return $background-color; // Darker background, return light color
  }
}

@function accent-color() {
  {% if not settings.primary_color %}
    $primary-color: #D61D40;
  {% else %}
    $primary-color: {{ settings.primary_color }};
  {% endif %}
  $secondary-color: {{ settings.secondary_color }};
  $accent-color: {{ settings.accent_color }};

  @if (brightness($primary-color) > 66) {
    @return $primary-color; // Lighter background, return dark color
  } @else if (brightness($secondary-color) > 66) {
    @return $secondary-color;
  } @else {
    @return $accent-color; // Darker background, return accent color
  }
}

@function calc-brightness() {
  {% if not settings.primary_color %}
    $primary-color: #D61D40;
  {% else %}
    $primary-color: {{ settings.primary_color }};
  {% endif %}
  $background-color: {{ settings.background_color }};
  $secondary-color: {{ settings.secondary_color }};

  @if (brightness($primary-color) > 66) {
    @return brightness($primary-color); // Lighter background, return dark color
  } @else if (brightness($secondary-color) > 66) {
    @return brightness($secondary-color);
  } @else {
    @return $background-color; // Darker background, return light color
  }
}

// See https://www.w3.org/TR/AERT/#color-contrast for original algorithm used for this function
@function color-difference($foreground, $background) {
  $r: (max(red($foreground), red($background))) - (min(red($foreground), red($background)));
  $g: (max(green($foreground), green($background))) - (min(green($foreground), green($background)));
  $b: (max(blue($foreground), blue($background))) - (min(blue($foreground), blue($background)));
  $sum-rgb: $r + $g + $b;
  
  @if $sum-rgb < 500 {
    @return "false";
  } @else {
    @return "true";
  }
}

@function color-or-color() {

  {% if not settings.primary_color %}
    $c1: #D61D40;
  {% else %}
    $c1: {{ settings.primary_color }};
  {% endif %}
  $c2: {{ settings.secondary_color }};
  $background: #ffffff;

  $r1: (max(red($c1), red($background))) - (min(red($c1), red($background)));
  $g1: (max(green($c1), green($background))) - (min(green($c1), green($background)));
  $b1: (max(blue($c1), blue($background))) - (min(blue($c1), blue($background)));
  $sum-rgb1: $r1 + $g1 + $b1;
  
  $r2: (max(red($c2), red($background))) - (min(red($c2), red($background)));
  $g2: (max(green($c2), green($background))) - (min(green($c2), green($background)));
  $b2: (max(blue($c2), blue($background))) - (min(blue($c2), blue($background)));
  $sum-rgb2: $r2 + $g2 + $b2;

  @if $sum-rgb1 < $sum-rgb2 {
    @return $c2;
  } @else {
    @return $c1;
  }
}

$dark-color: dark-color();
$darker-color: darker-color();
$lighter-color: lighter-color();
$dark-brand-color: dark-brand-color();
$text-on-primary: text-on-primary();
$light-color: light-color();
$color-color: accent-color();
$priority-color: color-or-color();

{% set show_actions = settings.show_add_button or settings.show_quickshop_button %}

{#/*============================================================================
  #Components
==============================================================================*/#}

{# /* // Margin and padding */ #}

%section-margin {
  margin-bottom: 70px;
}
%element-margin {
  margin-bottom: 20px;
}
%element-margin-half {
  margin-bottom: 10px;
}

{# /* // Mixins */ #}

@mixin text-decoration-none(){
  text-decoration: none;
  outline: 0;
  &:hover,
  &:focus{
    text-decoration: none;
    outline: 0;
  }
}

@mixin no-wrap(){
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  font-weight: normal;
}

@mixin drop-shadow(){
  -moz-box-shadow: 0 0 3px #ccc;
  -webkit-box-shadow: 0 0 3px #ccc;
  box-shadow: 0 0 3px #ccc;
}

@mixin text-contrast($n) {
  $color-brightness: round((red($n) * 299) + (green($n) * 587) + (blue($n) * 114) / 1000);
  $light-color: round((red(#ffffff) * 299) + (green(#ffffff) * 587) + (blue(#ffffff) * 114) / 1000);

  @if abs($color-brightness) < ($light-color/2){
    color: white;
  }
  @else {
    color: black;
  }
}

@mixin contrast($f, $b) {
  @while (color-difference($f, $b) == "false") {
    color: $f;
    $f: darken($f, 1%);
    @if (color-difference($f, $b) == "true") {
      color: $f;
    }
  }
}

{# This mixin adds browser prefixes to a CSS property #}

@mixin prefix($property, $value, $prefixes: ()) {
  @each $prefix in $prefixes {
      #{'-' + $prefix + '-' + $property}: $value;
  }
    #{$property}: $value;
}

{# /* // Animations */ #}

%simplefade {
  transition: all 0.5s ease;
}

{# /* // Wrappers */ #}

%body-font {
  {% if settings.font_rest_size %}
    font-size: {{ settings.font_rest_size }}px;
  {% else %}
    font-size: 14px;
  {% endif %}
}

.box{
  float: left;
  width: 100%;
  margin-bottom: 10px;
  padding: 10px;
}

{# /* // Placeholders */ #}

.placeholder-container{
  background-color:rgba($secondary-color, 0.1);
}
.placeholder-color{
  background-color:rgba($secondary-color, 0.07);
}
.placeholder-icon svg{
  fill:rgba($secondary-color, 0.2);
}
.placeholder-page{
  background: $secondary-color;
  &:hover,
  &.active{
      background: $primary-color;
      opacity: 0.8;
  }
}
.placeholder-shine{
  background-color:rgba($secondary-color, 0.2);
}

.placeholder-overlay {
    background-color:rgba($secondary-color, 0.3);
    opacity: 0;
    &:hover,
    &:active,
    &:focus {
        opacity: 1;
    }
}

.placeholder-info {
  color: $background-color;
  fill: $background-color;
  background-color: $primary-color;
  box-shadow: 0 1px 3px rgba(0,0,0,0.5);
  .placeholder-button {
    color: $primary-color;
    background-color: $background-color;
    opacity: 1;
    &:hover {
      opacity: .8;
    }
  }
}

.spinner-square {
  width: 20px;
  height: 10px;
  position: relative;
  margin: -20px auto 60px auto;
  animation: spinner-square  1s linear alternate infinite;
}

.spinner-square-invert {
  @extend .spinner-square;
  animation: spinner-square-invert  1s linear alternate infinite;
}

@keyframes spinner-square {
  0% {
    box-shadow: -60px 40px 0 2px rgba($secondary-color, 0.2), -30px 40px 0 0 rgba($secondary-color, 0.1), 0 40px 0 0 rgba($secondary-color, 0.1), 30px 40px 0 0 rgba($secondary-color, 0.1), 60px 40px 0 0 rgba($secondary-color, 0.1); 
  }
  25% {
    box-shadow: -60px 40px 0 0 rgba($secondary-color, 0.1), -30px 40px 0 2px rgba($secondary-color, 0.2), 0 40px 0 0 rgba($secondary-color, 0.1), 30px 40px 0 0 rgba($secondary-color, 0.1), 60px 40px 0 0 rgba($secondary-color, 0.1); 
  }
  50% {
    box-shadow: -60px 40px 0 0 rgba($secondary-color, 0.1), -30px 40px 0 0 rgba($secondary-color, 0.1), 0 40px 0 2px rgba($secondary-color, 0.2), 30px 40px 0 0 rgba($secondary-color, 0.1), 60px 40px 0 0 rgba($secondary-color, 0.1); 
  }
  75% {
    box-shadow: -60px 40px 0 0 rgba($secondary-color, 0.1), -30px 40px 0 0 rgba($secondary-color, 0.1), 0 40px 0 0 rgba($secondary-color, 0.1), 30px 40px 0 2px rgba($secondary-color, 0.2), 60px 40px 0 0 rgba($secondary-color, 0.1); 
  }
  100% {
    box-shadow: -60px 40px 0 0 rgba($secondary-color, 0.1), -30px 40px 0 0 rgba($secondary-color, 0.1), 0 40px 0 0 rgba($secondary-color, 0.1), 30px 40px 0 0 rgba($secondary-color, 0.1), 60px 40px 0 2px rgba($secondary-color, 0.2); 
  } 
}

@keyframes spinner-square-invert {
  0% {
    box-shadow: -60px 40px 0 2px rgba($background-color, 0.2), -30px 40px 0 0 rgba($background-color, 0.1), 0 40px 0 0 rgba($background-color, 0.1), 30px 40px 0 0 rgba($background-color, 0.1), 60px 40px 0 0 rgba($background-color, 0.1); 
  }
  25% {
    box-shadow: -60px 40px 0 0 rgba($background-color, 0.1), -30px 40px 0 2px rgba($background-color, 0.2), 0 40px 0 0 rgba($background-color, 0.1), 30px 40px 0 0 rgba($background-color, 0.1), 60px 40px 0 0 rgba($background-color, 0.1); 
  }
  50% {
    box-shadow: -60px 40px 0 0 rgba($background-color, 0.1), -30px 40px 0 0 rgba($background-color, 0.1), 0 40px 0 2px rgba($background-color, 0.2), 30px 40px 0 0 rgba($background-color, 0.1), 60px 40px 0 0 rgba($background-color, 0.1); 
  }
  75% {
    box-shadow: -60px 40px 0 0 rgba($background-color, 0.1), -30px 40px 0 0 rgba($background-color, 0.1), 0 40px 0 0 rgba($background-color, 0.1), 30px 40px 0 2px rgba($background-color, 0.2), 60px 40px 0 0 rgba($background-color, 0.1); 
  }
  100% {
    box-shadow: -60px 40px 0 0 rgba($background-color, 0.1), -30px 40px 0 0 rgba($background-color, 0.1), 0 40px 0 0 rgba($background-color, 0.1), 30px 40px 0 0 rgba($background-color, 0.1), 60px 40px 0 2px rgba($background-color, 0.2); 
  } 
}

{# /* // Dividers */ #}

.divider{
  margin-top: 20px;
  margin-bottom: 20px;
  clear: both;
}

.top-line {
  border-top: 1px solid rgba($text-color, .1);
}

{# /* // Breadcrumbs */ #}

.subtitle {
  .crumb {
    font-size: 16px;
    color: rgba($secondary-color, .5);
  }
  .divider {
    svg {
      vertical-align: 0;
      opacity: 0.5;
    }
  }
  h3.crumb.active {
    color: $secondary-color;
    font-size: 16px;
  }
}

.breadcrumbs {
  .crumb {
    font-size: 13px;
  }
  .divider {
    svg {
      vertical-align: 0;
    }
  }
  .crumb.active {
    color: $primary-color;
  }
}

.contact-product-page {
  .divider {
    border-bottom: 1px solid #e5e5e5;
  }
}

{# /* Headings */ #}

.page-header {
  @extend %element-margin;
  padding: 16px 0;
  background: rgba($secondary-color, .03);
  border-bottom: 1px solid rgba($text-color,.05);
  h1, .h1{
    margin-bottom: 0;
  }
  &-slim {
    padding: 15px 0;
    background: none;
  }
}

.page-header-product {
  padding: 0;
  margin: 0 0 10px;
  font-size: 12px;
}

{# /* // Buttons */ #}

.header-logo-row {
  padding: 5px 0;
  .logo-text-container {
    padding: 20px 5px;
  }
}

{# /* // Links */ #}

.link-invert {
  color: $background-color;
  fill: $background-color;
  &:hover,
  &:focus{
    color: rgba($background-color, .8);
    fill: rgba($background-color, .8);
  }
}

.btn-sort {
  color: $primary-color;
  fill: $primary-color;
  cursor: pointer;
  text-decoration: underline;
  &.invert{
    color: $background-color;
    fill: $background-color;
    &:hover,
    &:focus{
      color: $background-color;
      fill: $background-color;
      opacity: 0.5;
    }
  }
  &-primary{
    &:hover,
    &:focus{
      opacity: 0.5;
    }
  }
  &.no-underline {
    text-decoration: none;
  }
}

{# /* // Chips */ #}

.chip{
  color: $primary-color;
  background-color: rgba($primary-color, .08);
  &-remove-icon {
    background-color: $background-color;
    fill: $primary-color;
  }
}

{# /* // Progress bar */ #}

{% if settings.progressbar_colors == "default" %}
.bar-progress {
  background: #eee;
  &-active::before {
    content:"";
    position:absolute;
    top:0;
    left:0;
    right:0;
    bottom:0;
    background-image: linear-gradient(90deg, rgba(255,56,95,1) 0%, rgba(255,221,87,1) 50%, rgba(32,209,96,1) 100%);
  }
  &-active {
    -webkit-mask:linear-gradient(#fff 0 0);
            mask:linear-gradient(#fff 0 0);
  }
  &-check {
    background-color: $background-color;
    fill: #20d160;
  }
}
.ship-free-rest-text,
.ship-free-rest-message {
  .text-accent {
    color: $text-color;
  }
}
{% else %}
.bar-progress {
  background: rgba($primary-color, 0.1);
  &-active {
    background-image: linear-gradient(-90deg, rgba($accent-color, 1), rgba($accent-color, .2));
  }
  &-check {
    background-color: $background-color;
    fill: $accent-color;
  }
}
{% endif %}

{# /* // Modals */ #}

.modal{
  color: $text-color;
  background-color: $background-color;
}

.modal-centered-custom {
  .modal-header {
    background: rgba($text-color,.05);
  }
}

.modal-search-bg {
  display: block;
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba($background-color, .9);
}

{# /* // Home banners */ #}


{# /* // Grid Banners */ #}

.gridbanner {
  .btn-line {
    color: $background-color;
    fill: $background-color;
    border-color: $background-color;
    padding: 8px 20px 8px 24px;
    line-height: 18px;
    font-size: 14px;
  }
}

{# /* // Tabs */ #}

.tab-group{
  border-bottom: 1px solid rgba($secondary-color, .1);
  .tab{
    &-link{
      color: $secondary-color;
    }
    &.active{
      .tab-link{
        border-bottom: 2px solid rgba($primary-color, .5);
        color: $primary-color;
      }
    }
  }
}

{# /* // Sliders */ #}

.swiper-text {
  @extend %simplefade;
  opacity: 0;
}
.swiper-slide-active .swiper-text {
  opacity: 1;
}

.swiper-pagination-fraction{
  border-bottom: 1px solid rgba($text-color, .2);
}

.swiper-dark {
  color: $secondary-color;
}

.swiper-light {
  color: $background-color;
}

.swiper-pagination-bullet {
  background: $primary-color !important;
}

{# /* Shadows */ #}

.shadow {
  &-none {
    box-shadow: 0 0px 0px rgba(0,0,0,0.05), 
    0 0px 0px rgba(0,0,0,0.05), 
    0 0px 0px rgba(0,0,0,0.05), 
    0 0px 0px rgba(0,0,0,0.05),
    0 0px 0px rgba(0,0,0,0.05);
  }
  &-shorter {
    box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
    border-radius: 5px;
  }
  &-longer {
    box-shadow: 0 2px 1px rgba(0,0,0,0.09), 
    0 4px 2px rgba(0,0,0,0.09), 
    0 8px 4px rgba(0,0,0,0.09), 
    0 16px 8px rgba(0,0,0,0.09),
    0 32px 16px rgba(0,0,0,0.09);
  }
  &-soft {
    box-shadow: 0 1px 2px rgba(0,0,0,0.07), 
    0 2px 4px rgba(0,0,0,0.07), 
    0 4px 8px rgba(0,0,0,0.07), 
    0 8px 16px rgba(0,0,0,0.07),
    0 16px 32px rgba(0,0,0,0.07), 
    0 32px 64px rgba(0,0,0,0.07);
  }
  &-banner {
    box-shadow: 0 0 7px rgba(0,0,0,0.1);
  }
}

.zoom-in {
  & {
    transition: 250ms all ease-in-out;
  }
  &:hover {
    transform: scale(1.04);
  }
}

{# /* // Scrollbars */ #}

{# /*  Track */ #}
.custom-scrollbar::-webkit-scrollbar-track {
  background: rgba($secondary-color, .15); 
}

{# /*  Handle */ #}
.custom-scrollbar::-webkit-scrollbar-thumb {
  background: rgba($background-color, .9); 
}

{# /*  Handle on hover */ #}
.custom-scrollbar::-webkit-scrollbar-thumb:hover {
  background: rgba($background-color, .7); 
}


/*============================================================================
  #Home Page
==============================================================================*/

{# /* // Home sidebar categories */ #}

.nav-menu-box {
  &-title {
    border-bottom: 1px solid rgba($background-color, .2);
  }
  .nav-primary {
    .nav-list {
      &-link {
        color: $background-color;
        fill: $background-color;
      }
    } 
  }
  .list-subitems {
    background-color: darken($background-color,2%);
    .list-subitems {
      background-color: darken($background-color,4%);
    }
  }
  .nav-item {
    &:before {
      background-color: set-subnav-color(#eee);
      opacity: .4;
    }
  }
}

.desktop-dropdown,
.desktop-dropdown ul,
.subutility-list {
  {% if settings.theme_round == 'none' %}
    border-radius: 0;
  {% elseif settings.theme_round == 'min' %}
    border-radius: 3px;
  {% else %}
    border-radius: 8px;
  {% endif %}
}

.navigation-separator {
  content: '';
  width: 1px;
  height: 30px;
  position: absolute;
  top: 50%;
  right: 0;
  -webkit-transform: translateY(-50%);
  -moz-transform: translateY(-50%);
  -o-transform: translateY(-50%);
  transform: translateY(-50%);
  background: rgba($secondary-color,.1);
}

.item-with-subitems ul {
  .navigation-separator {
    display:none;
  }
}

.nav-desktop-list .nav-item:last-child {
  .navigation-separator {
    display:none;
  }
}

{# /* Testimonials */ #}

.fill-star {
  fill: #ffc107;
}

.home-testimonials {
  .swiper-button-prev {
    left: -30px;
  }
  .swiper-button-next {
    right: -30px;
  }
}

/*============================================================================
  #Product grid
==============================================================================*/

{# /* // Grid item */ #}

.item {

  &-description {
    &-container {
      &.show-sizes {
        background: $background-color;
      }
      background: $background-color;
      {% if show_actions %}
        padding: 10px 10px 3px;
      {% else %}
        padding: 15px;
        @media (max-width: 767px) {
          padding: 10px;
        }
      {% endif %}
    }
  }

  .placeholder-image {
    background: $background-color;
  }

  &-link {
    color: $text-color;
  }

  &-installments {
    color: $text-color;
  }

  &-actions {
    // border-top: 1px solid rgba($secondary-color, .05);
    &-line {
      // border-left: 1px solid rgba($secondary-color, .05);
    }
  }

  &-buy-close {
    background: $secondary-color;
    color: $background-color;
  }

  &.no-borders {
    .item-image {
      border: none;
    }
    &.item-horizontal {
      .item-image {
        border: 10px solid transparent;
      }
    }
    & > .product-container {
      border: none;
      &:hover {
        box-shadow: none;
      }
    }
  }

}

{# /* // Filters */ #}

.filter-remove {
  color: $primary-color;
  background: none;
  border: 1px solid rgba($primary-color,0.2);
  &:after{
    content: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 512" fill="%23{{ settings.secondary_color |trim('#') }}"><path d="M193.94 256L296.5 153.44l21.15-21.15c3.12-3.12 3.12-8.19 0-11.31l-22.63-22.63c-3.12-3.12-8.19-3.12-11.31 0L160 222.06 36.29 98.34c-3.12-3.12-8.19-3.12-11.31 0L2.34 120.97c-3.12 3.12-3.12 8.19 0 11.31L126.06 256 2.34 379.71c-3.12 3.12-3.12 8.19 0 11.31l22.63 22.63c3.12 3.12 8.19 3.12 11.31 0L160 289.94 262.56 392.5l21.15 21.15c3.12 3.12 8.19 3.12 11.31 0l22.63-22.63c3.12-3.12 3.12-8.19 0-11.31L193.94 256z"/></svg>');
  }
}

.pagination-bottom {
  padding: 15px;
  border-radius: 5px;
  background: #fafafa;
}


/*============================================================================
  #Product detail
==============================================================================*/

{# /* // Image */ #}

.thumb-see-more{
  background-color: rgba($background-color, .5);
  color: $primary-color;
  &:hover{
    background-color: rgba($background-color, .9);
  }
}

{# /* // Form and info */ #}

.product-promo-container {
  border: 2px solid $accent-color;
  border-radius: var(--theme-round);
}

.social-share {
  @extend %element-margin;
  .social-share-button {
    color: $secondary-color;
  }
}

.product-variants {
  margin-bottom: 20px;
  border-bottom:1px solid rgba($secondary-color, .1);
}

.product-tags span {
  background: rgba($secondary-color, .1);
}

/* Item container */

.bullet-variation, .js-btn-variation {
  font-size: 13px;
  font-weight: 700;
}

.bullet-variation {
  margin: 3px;
  padding: 2px;
}

.sizes {
  a {
    color: $text-color;
  }
  .js-btn-variation {
    padding: 6px 8px;
    margin-right: 5px;
  }
  .selected {
    background: rgba($primary-color, .2);
    border-color: $primary-color;
  }
}

.list-sizes {
  transition: 300ms all ease-in-out;
  opacity: 1;
  height: auto;
  visibility: visible;
  &.show-sizes {
    overflow: hidden;
    height: 0;
    opacity: 0;
    visibility: hidden;
  }
}

.product-seals .seal {
  font-size: {{ settings.font_rest_size }}px;
}

.user-content * {
  color: $text-color;
}

/*============================================================================
  #Account page
==============================================================================*/

{# /* // Order item */ #}

.order-item {
  padding: 15px 0;
  border-bottom: 1px solid rgba($secondary-color, .08);
  &:first-child {
    border-top: 1px solid rgba($secondary-color, .08);
  }
}

{# /* // Utilities */ #}

.subutility-list {
 background-color: $background-color;
 box-shadow: 0 1px 6px rgba(0,0,0,0.2);
}

.subutility-list {
  a {
    color: $text-color;
    &:hover {
      color: $primary-color;
    }
  }
}

.nav-hamburger .nav-list .nav-list-link.all-products {
  border: 1px solid $secondary-color !important;
  border-radius: 30px;
}

{# /* // Nav */ #}

.nav-desktop {
  .navigation-banner {
    position: unset;
  }
  .desktop-dropdown {
    .nav-list-arrow {
      position:absolute;
      right: 10px;
      top: 28%;
    }
    .nav-list-link {
      border-bottom: none;
      svg {
        fill: $text-color;
      }
      &:hover {
        border-bottom: none;
      }
    }
  }
  .col {
    padding-left: 7px;
    padding-right: 7px;
  }
}

.nav-hamburger {
  .modal-footer {
    background: rgba($secondary-color,.06);
  }
}

.desktop-dropdown {
  background: #fff;
}

{# /* // Mega menu */ #}

.mega-menu {
  width: 100vw;
  @media (min-width: 576px) {
    max-width: calc(540px - 40px);
  }
  @media (min-width: 768px) {
    max-width: calc(720px - 40px);
  }
  @media (min-width: 992px) {
    max-width: calc(960px - 40px);
  }
  @media (min-width: 1200px) {
    max-width: calc(1140px - 40px);
  }
  @media (min-width: 1280px) {
    max-width: calc(1240px - 40px);
  }
  @media (min-width: 1380px){
    max-width: calc(1300px - 40px);
  }
  .nav-item:before {
    display:none;
  }
  .desktop-list-subitems {
    .nav-item {
      padding: 0;
    }
  }
  .nav-item-container {
    a {
      position: relative;
      color: $text-color;
    }
    .nav-list-link {
      color: $text-color;
    }
  }
  .nav-list-link {
    line-height: 1;
  }
  .nav-subitem a {
    text-transform: none;
    font-size: 12px;
  }
}

{# /* // Search */ #}

.search-suggestions {
  background-color: $background-color;
  &-item {
    border-bottom: 1px solid rgba($background-color, .1);
  }
  a {
    color: $priority-color;
  }
  .btn {
    color: $background-color;
  }
}

{% if settings.payments_gray %}
  .footer-payments img {
    filter: grayscale(1);
  }
{% endif %}

{% if settings.shipping_gray %}
  .shipping-logos img {
    filter: grayscale(1);
  }
{% endif %}

{% if settings.footer_block_bg %}
.block-bg-custom {
  background: {{ settings.footer_block_bg }};
}
{% endif %}
.block-bg-secondary {
  background: $secondary-color;
}
.block-bg-brand {
  background: $primary-color;
}

{% if settings.footer_block_text_color %}
.block-text-custom {
  color: {{ settings.footer_block_text_color }};
  h4 {
    color: {{ settings.footer_block_text_color }};
  }
}
{% endif %}
.block-text-text {
  color: $text-color;
}
.block-text-brand {
  color: $primary-color;
}

.footer-legal {
  border-top: 1px solid rgba(#000, .1);  
  .h4 {
    font-weight: 500;
    font-size: 16px;
  }

}

.element-footer {
  @extend %element-margin;
}

{#/*============================================================================
  #Media queries
==============================================================================*/ #}


{# /* // Min width 768px */ #}

@media (min-width: 768px) { 

  {# /* Buttons */ #}

  .btn-medium {
    padding: 13px 15px;
  }

}
