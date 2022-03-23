from ipykernel.kernelbase import Kernel
import irisnative
import cgi
import json


def get_iris_object():
    # Load vars
    fObj = open('/home/irisowner/.local/share/jupyter/kernels/objectscript/connection.json',)
    vars = json.load(fObj)

    # Create connection to InterSystems IRIS
    connection = irisnative.createConnection(vars["host"], vars["port"], vars["namespace"], vars["login"], vars["password"])

    # Create an iris object
    return irisnative.createIris(connection)


class ObjectScriptKernel(Kernel):
    implementation = 'object_script'
    implementation_version = '1.0'
    language = 'no-op'
    language_version = '1.0'
    banner = 'An ObjectScript kernel'
    language_info = {
        'name': 'objectscript-int',
        'mimetype': 'text/plain',
        'file_extension': '.int',
    }

    def __init__(self, **kwargs):
        Kernel.__init__(self, **kwargs)
        self.iris = get_iris_object()

    def execute_code(self, code, type):
        class_name = "ObjectScript.Kernel.CodeExecutor"
        return self.iris.classMethodValue(class_name, "CodeResult", code, type)

    def do_execute(self, code, silent, store_history=True, user_expressions=None,
                   allow_stdin=False):
        if not silent:
            output = []
            arg = 'cos'

            if code.splitlines()[0].startswith('%'):
                arg = code.splitlines()[0].split('%')[1]
                if arg != 'cos':
                    code = "\n".join(code.splitlines()[1:])
                else:
                    code = " ".join(code.splitlines()[1:])
            else:
                code = " ".join(code.splitlines()[0:])


            execution_result = json.loads(self.execute_code(code,arg))

            if execution_result['status']:
                if execution_result['out']:
                    output.append(execution_result['out'])
            else:
                self.send_error_msg(execution_result['out'])
                return {
                        'status': 'error',
                        'execution_count': self.execution_count,
                        'payload': [],
                        'user_expressions': {},
                    }

        self.send_execution_result('\n'.join(output))
        return {
            'status': 'ok',
            'execution_count': self.execution_count,
            'payload': [],
            'user_expressions': {},
        }

    def send_execution_result(self, msg_text):
        msg = {'name': 'stdout', 'text': msg_text}
        self.send_response(self.iopub_socket, 'stream', msg)

    def send_error_msg(self, excecution_exception):

        msg_html = (f'<p><span class="ansi-red-fg">{excecution_exception}</span></p>')

        msg = {
                'source': 'kernel',
                'data': {
                    'text/html': msg_html
                },
                'metadata' : {}
            }

        self.send_response(self.iopub_socket, 'display_data', msg)


if __name__ == '__main__':
    from ipykernel.kernelapp import IPKernelApp
    IPKernelApp.launch_instance(kernel_class=ObjectScriptKernel)
