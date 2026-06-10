import streamlit as st

st.set_page_config(page_title="Tarefas", page_icon="📝", layout="wide")

try:
    with open("style.css") as f:
        st.markdown(f"<style>{f.read()}</style>", unsafe_allow_html=True)
except FileNotFoundError:
    pass

st.title("Minhas Tarefas")

col1, col2 = st.columns([3, 1]) # Coluna 1 é 3x maior que a 2
with col1:
    search = st.text_input("Buscar tarefa...", placeholder="Ex: Estudar Pandas")
with col2:
    filtro = st.selectbox("Status", ["Todas", "Pendente", "Concluída"])

st.markdown("---")

# Exemplo de Expander para detalhes
with st.expander("📌 Tarefa 01: Configuração do Ambiente (Clique para ver)", expanded=True):
    st.write("**Disciplina:** Innovation Lab")
    st.write("**Prazo:** 20/02/2026")
    st.checkbox("Marcar como Concluída", value=True)
