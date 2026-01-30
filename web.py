from flask import Flask, request, jsonify, render_template
from React import ReActAgent
from LLM import HelloAgentsLLM
from tools import ToolExecutor, search

app = Flask(__name__, template_folder='templates')

# 初始化 agent（复用现有类）
llm = HelloAgentsLLM()
tool_executor = ToolExecutor()
tool_executor.register_tool("Search", "网页搜索工具", search)
agent = ReActAgent(llm_client=llm, tool_executor=tool_executor)


@app.route('/')
def index():
    return render_template('index.html')


@app.route('/api/query', methods=['POST'])
def api_query():
    data = request.get_json(force=True)
    question = data.get('question', '').strip()
    if not question:
        return jsonify({'error': 'empty question'}), 400

    # 同步调用 agent.run（可能耗时）
    answer = agent.run(question)
    return jsonify({'answer': answer})


if __name__ == '__main__':
    import os
    port = int(os.environ.get('PORT', 5001))
    debug = os.environ.get('FLASK_ENV') == 'development'
    app.run(host='0.0.0.0', port=port, debug=debug)
