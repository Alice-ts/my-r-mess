# Load required libraries
library(ggplot2)
library(dplyr)

# Parameters
m1 <- 10  # x-axis value for m*1
B <- 2    # Offset for mean
mean <- m1 - B
std_dev <- 1

# Generate x values
x <- seq(mean - 4*std_dev, mean + 4*std_dev, length.out = 1000)

# Calculate the normal distribution values
y <- dnorm(x, mean, std_dev)

# Create the plot
plot_data <- data.frame(x = x, y = y)

# Fill the area of the first half of the graph
fill_data1 <- data.frame(x = seq(mean - 4*std_dev, m1 - B, length.out = 1000), y = dnorm(seq(mean - 4*std_dev, m1 - B, length.out = 1000), mean, std_dev))

# Fill the area between m*1 and the mean
fill_data2 <- data.frame(x = seq(m1 - B, m1, length.out = 1000),
                         y = dnorm(seq(m1 - B, m1, length.out = 1000), mean, std_dev))

# Create the plot using ggplot2
p <- ggplot() +
  geom_area(data = fill_data1, aes(x = x, y = y), fill = "lightblue", alpha = 0.5, show.legend = FALSE) +
  geom_area(data = fill_data2, aes(x = x, y = y), fill = "lightgreen", alpha = 0.5, show.legend = FALSE) +
  geom_line(data = plot_data, aes(x = x, y = y), color = "black") +
  geom_point(data = data.frame(x = m1 - B, y = dnorm(m1 - B, mean, std_dev)), aes(x = x, y = y), color = "red") +
  annotate("text", x = (mean) - 1.5 , y = 0.01, label = "H(m*1 - B)", color = "black", size = 3) +
  annotate("text", x = (mean + m1) / 2, y = 0.01, label = "H(m*1) - H(m*1 - B)", color = "black", size = 3) +
  annotate("text", x = (mean) - 1.5 , y = 0.03, label = "Area of the first half", color = "black", size = 3) +
  annotate("text", x = (mean + m1) / 2, y = 0.03, label = "Area between m*1 and mean", color = "black", size = 3) +
  labs(x = "m1", y = "h(.)", title = "Normal Distribution with Specified Characteristics") +
  theme_minimal() +
  theme(axis.text = element_blank(), axis.ticks = element_blank(), legend.position = "bottom")

print(p)
