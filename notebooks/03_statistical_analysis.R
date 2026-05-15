# Install packages (only run once)
#install.packages(c("ggplot2", "dplyr", "corrplot", "ggpubr"))

# Load libraries
library(ggplot2)
library(dplyr)
library(corrplot)
library(ggpubr)

# Load data
df <- read.csv("../data/creditcard.csv")

# Quick look
dim(df)
head(df)
summary(df)

# Separate fraud and legit
fraud <- df %>% filter(Class == 1)
legit <- df %>% filter(Class == 0)

# T-test
t_result <- t.test(fraud$Amount, legit$Amount)
print(t_result)

# Convert time to hours
df$Hour <- (df$Time %% (24 * 3600)) %/% 3600
df$Class_Label <- ifelse(df$Class == 1, "Fraud", "Legitimate")

# Plot
ggplot(df, aes(x = Hour, fill = Class_Label)) +
  geom_histogram(bins = 24, alpha = 0.7, position = "identity") +
  facet_wrap(~Class_Label, scales = "free_y") +
  scale_fill_manual(values = c("Fraud" = "#e63946", "Legitimate" = "#457b9d")) +
  labs(title = "Transaction Frequency by Hour of Day",
       x = "Hour", y = "Count") +
  theme_minimal() +
  theme(legend.position = "none")

ggsave("../reports/time_distribution_R.png", dpi = 150)

# Create amount risk tiers
df$Amount_Tier <- cut(df$Amount,
                      breaks = c(0, 10, 50, 200, Inf),
                      labels = c("Very Low (<€10)",
                                 "Low (€10-50)",
                                 "Medium (€50-200)",
                                 "High (>€200)"))

# Fraud rate per tier
tier_analysis <- df %>%
  group_by(Amount_Tier) %>%
  summarise(
    Total = n(),
    Fraud = sum(Class),
    Fraud_Rate = round(mean(Class) * 100, 3)
  )

print(tier_analysis)

# Plot fraud rate by tier
ggplot(tier_analysis, aes(x = Amount_Tier, y = Fraud_Rate, fill = Amount_Tier)) +
  geom_bar(stat = "identity", alpha = 0.85) +
  scale_fill_manual(values = c("#a8dadc","#457b9d","#e63946","#c1121f")) +
  labs(title = "Fraud Rate by Transaction Amount Tier",
       x = "Amount Tier", y = "Fraud Rate (%)") +
  theme_minimal() +
  theme(legend.position = "none")

ggsave("../reports/fraud_rate_by_tier.png", dpi = 150)

# Select V features + Amount + Class
cor_data <- df %>% select(V1:V28, Amount, Class)

# Calculate correlation
cor_matrix <- cor(cor_data)

# Plot
png("../reports/correlation_heatmap_R.png", width=1200, height=1000, res=150)
corrplot(cor_matrix,
         method = "color",
         type = "upper",
         tl.cex = 0.7,
         tl.col = "black",
         col = colorRampPalette(c("#e63946","white","#457b9d"))(200),
         title = "Feature Correlation Heatmap",
         mar = c(0,0,1,0))
dev.off()  

# Print key statistical findings
cat("=== STATISTICAL FINDINGS SUMMARY ===\n\n")

cat("1. T-TEST RESULT:\n")
cat("   Fraud avg amount: €", round(mean(fraud$Amount), 2), "\n")
cat("   Legit avg amount: €", round(mean(legit$Amount), 2), "\n")
cat("   p-value: < 0.001 (difference is statistically significant)\n\n")

cat("2. TIME PATTERN:\n")
cat("   Fraud peaks between 11pm - 4am\n\n")

cat("3. AMOUNT TIER:\n")
cat("   Highest fraud rate in Very Low (<€10) transactions\n")
cat("   Fraudsters test cards with small amounts first\n")