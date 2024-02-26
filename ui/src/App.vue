<script>
    import NUI from './components/NUI.vue';

    export default {
        data() {
            return {
                show: false,
                data: [],
                buttons: []
            }
        },
        methods: {
            ShowDialogue: function() {
                this.show = true;
            },
            HideDialogue: function() {
                this.show = false;
                NUI.methods.NUICallback('closedialogue');
            },
            SendEvent: function(button) {
                if (button.action === 'goBack') {
                    this.GoBack();
                } else {
                    NUI.methods.NUICallback('fireeventtrigger', { event: button.event, type: button.type });
                }

                if (button.shouldClose) {
                    this.HideDialogue();
                }
            },
            UpdateButons: function(buttons) {
                if (this.data.buttons.length > 0) {
                    this.buttons.push(this.data.buttons);
                }
                this.data.buttons = buttons;
            },
            GoBack: function() {
                if (this.buttons.length > 0) {
                    this.data.buttons = this.buttons.pop();
                }
            }
        },
        mounted() {
            this.listener = window.addEventListener('message', (event) => {
                switch (event.data.action) {
                    case 'senddialogue':
                        this.data = event.data;
                        this.ShowDialogue()
                        break;
                    case 'updatebuttons':
                        this.UpdateButons(event.data.buttons);
                        break;
                    case 'closedialogue':
                        this.HideDialogue();
                        break;
                }
            });

            this.listener = window.addEventListener('keyup', (event) => {
                if (event.key === 'Escape') {
                    this.HideDialogue();
                }
            });
        },
    }
</script>

<template>
    <div class="container" v-show='this.show'>
        <div class='menu'>
            <div class='content_info'>
                <span class='ped_name'>{{ data.pedName }}</span>
                <div class="info_right">
                    <span class='ped_job' v-if=" data.dialogueName ">{{ data.dialogueName }}</span>
                    <span class='player_rep' v-if="data.reputation > 0">
                        <span class='rep_number'>{{ data.reputation }}</span> Rep
                    </span>
                </div>
            </div>
            <div class='content_container'>
                <p class='dialogue'>
                    {{ data.dialogue}}
                </p>
            </div>

            <div class='player_options'>
                <button class='option' v-for='button in this.data.buttons' @click="SendEvent(button)">
                    <i :class='button.icon ? button.icon : "fas fa-circle"' class='icon'></i> {{ button.label }}
                </button>
            </div>
        </div>
    </div>
</template>



<style>
    .container {
        height: 100vh;
        justify-content: center;
        display: flex;
        background-image: radial-gradient(circle, #ffffff00 55%, #20212b 100%);
    }

    .menu {
        display: flex;
        flex-direction: column;
        position: absolute;
        bottom: 2vh;
        width: 25vw;
        max-width: 25vw;
        height: auto;
        border-radius: 8px;
        padding: 5px;
        background-color: #20212b;
    }

    .content_info {
        display: flex;
        flex-direction: row;
        justify-content: space-between;
        padding: 10px;
        color: #8b8dac;
        text-transform: capitalize;
    }

    .ped_name {
        font-size: 20px;
        font-weight: 600;
        color: white;
    }

    .info_right {
        display: flex;
        flex-direction: row;
        align-items: flex-end;
        gap: 10px;
    }

    .ped_job,
    .player_rep {
        font-size: 12px;
        font-weight: 600;
        background-color: #313241;
        padding: 6px 10px;
        border-radius: 8px;
    }

    .content_container {
        color: white;
        padding: 10px;
        margin: 5px;
        border-radius: 8px;
        font-size: 12px;
        overflow: auto;
        background-color: #313241;
    }

    .player_options {
        display: flex;
        flex-direction: row;
    }

    .option {
        display: flex;
        align-items: center;
        justify-content: center;
        background-color: #313241;
        color: #fff;
        font-weight: 600;
        border: none;
        padding: 10px;
        border-radius: 5px;
        width: 100%;
        max-width: 50%;
        margin: 5px;
        text-transform: capitalize;
        cursor: pointer;
    }

    .icon {
        margin-right: 10px;
    }

    .option img {
        width: 20px;
        height: 20px;
    }

    .option:hover {
        background-color: #424357;
    }

</style>