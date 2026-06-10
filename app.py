import streamlit as st
import pandas as pd
import numpy as np

# Configuração da Página (Título na aba do navegador)
st.set_page_config(page_title="EduTrack AI - Dashboard", page_icon="🎓", layout="wide")

# Carregar CSS Personalizado
try:
    with open("style.css") as f:
        st.markdown(f"<style>{f.read()}</style>", unsafe_allow_html=True)
except FileNotFoundError:
    pass

# Título Principal
st.title("🎓 EduTrack AI Dashboard")
st.markdown("Bem-vindo de volta! É bom ver você novamente.")

# Exemplo de Métrica Visual (3 cards como no Figma)
st.markdown("<br>", unsafe_allow_html=True)
col1, col2, col3 = st.columns(3)
col1.metric("Disciplinas Ativas", "4", "Neste semestre")
col2.metric("Tarefas Pendentes", "12", "-2 desde ontem", delta_color="inverse")
col3.metric("Horas de Estudo", "36", "11 esta semana")

st.markdown("<br><br>", unsafe_allow_html=True)
st.subheader("Estatísticas de Estudo")

# Mockup de gráfico semelhante ao do Figma
chart_data = pd.DataFrame(
    np.random.randn(7, 2).cumsum(axis=0) + 10,
    columns=['Esta Semana', 'Semana Passada'],
    index=["Seg", "Ter", "Qua", "Qui", "Sex", "Sáb", "Dom"]
)
st.line_chart(chart_data)