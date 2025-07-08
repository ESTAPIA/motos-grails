// DRY principle - Common CRUD operations
class CrudManager {
    constructor(controller, entityName) {
        this.controller = controller;
        this.entityName = entityName;
        this.setupEventHandlers();
    }

    // KISS principle - simple form submission
    submitForm(formId = null) {
        const $form = $(formId || `#frm${this.entityName}`);
        $.ajax({
            type: "POST",
            url: $form.attr("action"),
            data: $form.serialize(),
            success: (msg) => {
                if (msg === 'ok') {
                    this.showSuccessAlert();
                    setTimeout(() => location.reload(true), 1000);
                } else {
                    log(`Error al guardar ${this.entityName.toLowerCase()}`, "error");
                }
            }
        });
    }

    // DRY principle - common delete functionality
    deleteRow(itemId) {
        bootbox.dialog({
            title: "Alerta",
            message: `<i class='fa fa-trash fa-3x pull-left text-danger'></i>
                     <p>¿Está seguro que desea eliminar ${this.entityName.toLowerCase()} seleccionado?</p>`,
            closeButton: false,
            buttons: {
                cancelar: {
                    label: "Cancelar",
                    className: "btn-primary"
                },
                eliminar: {
                    label: "<i class='fa fa-trash'></i> Eliminar",
                    className: "btn-danger",
                    callback: () => {
                        $.ajax({
                            type: "POST",
                            url: `/${this.controller}/delete_ajax`,
                            data: { id: itemId },
                            success: (msg) => {
                                if (msg === 'ok') {
                                    setTimeout(() => location.reload(), 300);
                                } else {
                                    log(`Error al borrar ${this.entityName.toLowerCase()}`, "error");
                                }
                            }
                        });
                    }
                }
            }
        });
    }

    // KISS principle - simplified modal creation
    createEditRow(id = null) {
        const title = id ? "Editar" : "Crear";
        const data = id ? { id } : {};
        
        $.ajax({
            type: "POST",
            url: `/${this.controller}/form_ajax`,
            data: data,
            success: (msg) => {
                bootbox.dialog({
                    title: `${title} ${this.entityName}`,
                    closeButton: false,
                    message: msg,
                    buttons: {
                        cancelar: {
                            label: "Cancelar",
                            className: "btn-primary"
                        },
                        guardar: {
                            label: "<i class='fa fa-save'></i> Guardar",
                            className: "btn-success",
                            callback: () => this.submitForm()
                        }
                    }
                });
            }
        });
    }

    showSuccessAlert() {
        $('.alert').removeClass("hidden").addClass("show").alert();
    }

    // DRY principle - common event handlers
    setupEventHandlers() {
        $(document).on('click', '.btnCrear', () => {
            this.createEditRow();
            return false;
        });

        $(document).on('click', '.btn-edit', (e) => {
            const id = $(e.currentTarget).data("id");
            this.createEditRow(id);
        });

        $(document).on('click', '.btn-borrar', (e) => {
            const id = $(e.currentTarget).data("id");
            this.deleteRow(id);
        });
    }
}
