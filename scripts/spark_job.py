# Load necessary libraries
from pyspark.sql import SparkSession
from pyspark.sql.functions import avg, count, col

# Initialize Spark Session
spark = SparkSession.builder \
    .appName("BigDataAnalytics") \
    .getOrCreate()

print("Spark Session Created Successfully!")

# Sample data processing
data = [("Product A", 100), ("Product B", 200), ("Product C", 150), ("Product A", 50)]
columns = ["product", "sales"]

df = spark.createDataFrame(data, columns)

# Perform analytics
print("\n=== Data Analytics Results ===")
print("Sample Data:")
df.show()

print("Total Sales by Product:")
df.groupBy("product").sum("sales").show()

print("Average Sales:", df.agg(avg("sales")).collect()[0][0])
print("Total Records:", df.count())

# Stop Spark session
spark.stop()
print("\nSpark Session Stopped")