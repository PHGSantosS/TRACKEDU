import streamlit as st

st.set_page_config(page_title="Perfil", page_icon="👤", layout="wide")

try:
    with open("style.css") as f:
        st.markdown(f"<style>{f.read()}</style>", unsafe_allow_html=True)
except FileNotFoundError:
    pass

st.title("Meu Perfil")

st.write("Em breve: Gestão de conta e configurações do usuário.")
