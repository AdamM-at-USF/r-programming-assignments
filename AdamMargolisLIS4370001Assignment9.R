# Assignment #9: Visualization in R – Base Graphics, Lattice, and ggplot2
# Dataset: mtcars (Motor Trend Car Road Tests)

# 0. Load and inspect the dataset
data("mtcars", package = "datasets")
head(mtcars)

# Ensure categorical variables are treated as factors where appropriate
mtcars$cyl <- factor(mtcars$cyl)
mtcars$gear <- factor(mtcars$gear)


# ==========================================
# 1. Base R Graphics
# ==========================================

# Plot 1: Base Scatter plot (mpg vs. hp colored/grouped by cyl)
plot(mtcars$hp, mtcars$mpg,
     main   = "Base: MPG vs. Horsepower",
     xlab   = "Gross Horsepower (hp)",
     ylab   = "Miles Per Gallon (mpg)",
     pch    = 19,
     col    = as.numeric(mtcars$cyl) + 1)

# Plot 2: Base Histogram (Distribution of mpg)
hist(mtcars$mpg,
     main   = "Base: Distribution of MPG",
     xlab   = "Miles Per Gallon (mpg)",
     col    = "lightblue",
     border = "black")


# ==========================================
# 2. Lattice Graphics
# ==========================================
library(lattice)

# Plot 3: Conditional scatter plot (mpg vs. hp conditioned on cylinders)
xyplot(mpg ~ hp | cyl,
       data = mtcars,
       main = "Lattice: MPG vs. Horsepower by Cylinder Count",
       xlab = "Gross Horsepower",
       ylab = "Miles Per Gallon",
       pch  = 19)

# Plot 4: Box-and-whisker plot (mpg by number of gears)
bwplot(mpg ~ gear,
       data = mtcars,
       main = "Lattice: MPG Distribution by Gear Count",
       xlab = "Number of Forward Gears",
       ylab = "Miles Per Gallon")


# ==========================================
# 3. ggplot2 Graphics
# ==========================================
library(ggplot2)

# Plot 5: Scatter plot with smooth regression lines by cylinder group
ggplot(mtcars, aes(x = hp, y = mpg, color = cyl)) +
  geom_point(size = 3) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "ggplot2: MPG vs. Horsepower with Trend by Cylinders",
       x = "Gross Horsepower",
       y = "Miles Per Gallon",
       color = "Cylinders") +
  theme_minimal()

# Plot 6: Faceted histogram (Distribution of hp faceted by gears)
ggplot(mtcars, aes(x = hp)) +
  geom_histogram(binwidth = 20, fill = "steelblue", color = "white") +
  facet_wrap(~ gear) +
  labs(title = "ggplot2: Horsepower Distribution Faceted by Gears",
       x = "Gross Horsepower",
       y = "Count") +
  theme_minimal()


# ==========================================
# 4. Blog Discussion
# ==========================================
"When comparing the three visualization systems, Base R feels like 
drawing on a blank canvas using a step-by-step, procedural approach 
with traditional function calls. Lattice shifts into a more structured 
formula-based syntax designed specifically for multi-panel conditioned 
plots, while ggplot2 adopts a powerful Grammar of Graphics framework 
where plots are built iteratively by adding distinct layers with a + sign. 
Among them, ggplot2 delivered the most publication-quality output with 
minimal code thanks to its intelligent defaults and clean themes, though 
switching back and forth presented a slight learning curve—particularly 
remembering how ggplot2 strictly handles groupings and aesthetics inside 
aes() compared to the more direct parameter arguments of Base R."