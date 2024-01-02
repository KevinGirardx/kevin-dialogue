<script>
import NUI from './components/NUI.vue';

export default {
    data() {
        return {
            show: false,
            data: [],

            // data: { // Dummy data for testing
            //     pedName: 'John Doe',
            //     jobName: 'Police Officer',
            //     reputation: 100,
            //     dialogue: 'Hello, how are you?',
            //     buttons: [
            //         { icon:'fas fa-check', label: 'Accept', action: 'accept' },
            //         { icon: 'fas fa-times', label: 'Decline', action: 'decline'},               
            //         { label: 'Decline', action: 'decline'},               
            //     ],
            // },
        }
    },

    methods: {
        ShowDialogue: function() {
            this.show = true;
        },
        HideDialogue: function() {
            this.show = false;
            NUI.methods.NUICallback('removedialogue');
        },
        SendEvent: function(button) {
            this.HideDialogue()
            NUI.methods.NUICallback('fireeventtrigger', { event: button.event, type: button.type });
        },
    },

    mounted() {
        this.listener = window.addEventListener('message', (event) => {
            switch (event.data.action) {
                case 'senddialogue':
                    this.data = event.data;
                    this.ShowDialogue()
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
    <div class='container' v-show='this.show'>
        <div class='content_info'>
            <span class='ped_name'>{{ data.pedName }}</span>
            <span class='ped_job'>{{ data.jobName }}</span>
            <span class='player_rep'>
                <span class='rep_number'>{{ data.reputation}}</span> Rep
            </span>
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
</template>

<style>
.container {
    display: flex;
    flex-direction: column;
    position: absolute;
    bottom: 2vh;
    left: 50%;
    transform: translateX(-50%);
    width: 25vw;
    border-radius: 8px;
    background-color: #20212b;
}

.content_info {
    display: flex;
    justify-content: space-between;
    padding: 10px;
    color: #8b8dac;
}

.ped_name {
    font-size: 20px;
    color: white;
}

.ped_job,
.player_rep {
    font-size: 12px;
    font-weight: 600;
    background-color: #313241;
    padding: 4px;
    border-radius: 8px;
}

.ped_job {
    margin-right: -180px;
}

.content_container {
    color: white;
    padding: 5px;
    margin: 5px;
    border-radius: 8px;
    font-size: 12px;
    overflow: auto;
    background-color: #313241;
}

.player_options {
    display: flex;
}

.option {
    background-color: #313241;
    color: #fff;
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