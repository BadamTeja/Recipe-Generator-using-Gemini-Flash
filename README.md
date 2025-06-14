# 🍽️ Recipe Generator Using Gemini + Streamlit

This Streamlit web app takes a **food image** as input and uses **Gemini (Google Generative AI)** to:
- Recognize the food
- Identify ingredients
- Suggest a recipe with variations based on dietary preferences

---

## 🚀 Features

- Upload food image (.jpg/.png/.webp)
- Get recipe suggestions powered by Gemini Pro Vision
- Fast and simple UI with Streamlit

---

## 🛠️ Installation Steps

### 1. Clone the Repository

```bash
git clone https://github.com/YOUR_USERNAME/recipe-generator-using-gemini.git
cd recipe-generator-using-gemini
````

### 2. Create Virtual Environment (Optional but recommended)

```bash
python -m venv venv
# Activate it
venv\Scripts\activate         # On Windows
source venv/bin/activate      # On Mac/Linux
```

### 3. Install Dependencies

```bash
pip install -r requirements.txt
```

### 4. Set up Environment Variable

Create a `.env` file in the root directory:

```
GOOGLE_API_KEY=your_google_api_key_here
```

You can get your API key from: [https://makersuite.google.com/app/apikey](https://makersuite.google.com/app/apikey)

---

## 🧪 Run the App

```bash
streamlit run app.py
```

---

## 📁 File Structure

```
├── app.py                  # Main Streamlit app
├── .env                    # Your Google API key (not shared)
├── requirements.txt        # All Python dependencies
└── README.md               # Project guide and documentation
```

---

## ✨ Demo

![image](https://github.com/user-attachments/assets/5c90187a-6862-4075-8ca4-f1c8dbd6290a)
![image](https://github.com/user-attachments/assets/f2b051e5-9b71-4e53-9ed9-cf7291b04828)


---

## 📌 Notes

* This uses **Gemini 1.5 Flash** model from `google-generativeai`.
* Make sure your API key has access to `generativeLanguage` and `multimodal` features.

---

## 💡 Future Ideas

* Add support for multiple dish detection
* Dietary customization (vegan/keto filters)
* Recipe saving & download feature

---

## 📬 Contact

Created by [Your Name](https://github.com/YOUR_USERNAME) – feel free to reach out!

```

---

Let me know if you want me to generate a `requirements.txt` or `.env` template too.
```
