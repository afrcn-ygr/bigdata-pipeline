import pandas as pd
import sys
import os

def analyze_data(file_path='data.csv'):
    """Perform basic analytics on CSV data"""
    
    print("=" * 50)
    print("DATA ANALYTICS SERVICE")
    print("=" * 50)
    
    # Check if file exists
    if not os.path.exists(file_path):
        print(f"Error: {file_path} not found!")
        return
    
    # Read CSV
    df = pd.read_csv(file_path)
    
    print(f"\n📊 Dataset Information:")
    print(f"   - Total rows: {len(df)}")
    print(f"   - Columns: {list(df.columns)}")
    
    print(f"\n📈 Statistical Analysis:")
    
    if 'value' in df.columns:
        print(f"   - Sum: {df['value'].sum():.2f}")
        print(f"   - Average: {df['value'].mean():.2f}")
        print(f"   - Minimum: {df['value'].min():.2f}")
        print(f"   - Maximum: {df['value'].max():.2f}")
        print(f"   - Standard Deviation: {df['value'].std():.2f}")
    else:
        # Generic analysis for any numeric column
        numeric_cols = df.select_dtypes(include=['number']).columns
        for col in numeric_cols:
            print(f"\n   Column: {col}")
            print(f"   - Sum: {df[col].sum():.2f}")
            print(f"   - Average: {df[col].mean():.2f}")
            print(f"   - Min: {df[col].min():.2f}")
            print(f"   - Max: {df[col].max():.2f}")
    
    print("\n" + "=" * 50)
    print("✅ Analysis Complete!")
    print("=" * 50)

if __name__ == "__main__":
    # Allow custom file path as argument
    file_path = sys.argv[1] if len(sys.argv) > 1 else 'data.csv'
    analyze_data(file_path)