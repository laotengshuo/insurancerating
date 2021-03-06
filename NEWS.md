# insurancerating 0.6.2

* `reduce()` is added to reduce an insurance portfolio by merging redundant date ranges
* `summary.reduce()` takes an object produced by `reduce()`, and counts new and lost customers

# insurancerating 0.6.1

* `univariate_all()` and `autoplot.univ_all()` are now depreciated; use `univariate()` and `autoplot.univariate()` instead

# insurancerating 0.6.0

* `label_width` in `autoplot()` is added to wrap long labels in multiple lines
* `sort_manual` in `autoplot()` is added to sort risk factors into an own ordering
* `autoplot()` now works without manually loading package `ggplot2` and `patchwork` first
* `rating_factors()` now returns an object of class `riskfactor`
* `autoplot.riskfactor()` is added to create the corresponding plots to the output given by `rating_factors()`

# insurancerating 0.5.2

* `autoplot.univ_all()` now gives correct labels on the x-axis when `ncol` > 1. 

# insurancerating 0.5.1

* A package website is added using pkgdown.
* `construct_tariff_classes()` and `fit_gam()` now only returns tariff classes and fitted gam respectively; other items are stored as attributes.
* `univariate_frequency()`, `univariate_average_severity()`, `univariate_risk_premium()`, `univariate_loss_ratio()`, `univariate_average_premium()`, `univariate_exposure()`, and `univariate_all()` are added to perform an univariate analysis on an insurance portfolio.
* `autoplot()` creates the corresponding plots to the summary statistics calculated by `univariate_*`.

# insurancerating 0.5.0

* `construct_tariff_classes()` is now split in `fit_gam()` and `construct_tariff_classes()`.
* A vignette is added on how to use the package.

# insurancerating 0.4.3
 
* `period_to_months()` is added to split rows with a time period longer than one month to multiple rows with a time period of exactly one month each.

# insurancerating 0.4.2

* In `construct_tariff_classes()`, `model` now also accepts 'severity' as specification.   



